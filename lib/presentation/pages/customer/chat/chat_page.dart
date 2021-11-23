import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_shop/common/mixins/loading_view.dart';
import 'package:furniture_shop/configs/service_locator.dart';
import 'package:furniture_shop/data/model/response/chat_response.dart';
import 'package:furniture_shop/generated/assets/assets.gen.dart';
import 'package:furniture_shop/generated/assets/fonts.gen.dart';
import 'package:furniture_shop/presentation/pages/customer/chat/chat_bloc.dart';
import 'package:furniture_shop/presentation/pages/customer/chat/chat_state.dart';
import 'package:furniture_shop/presentation/pages/customer/chat/message_page/widget/chat_input_field.dart';
import 'package:furniture_shop/presentation/pages/customer/chat/message_page/widget/message.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_appbar.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class ChatPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChatPageState();
  }
}

class _ChatPageState extends State<ChatPage> with LoadingViewMixin {
  ChatPageBloc _bloc = ChatPageBloc(appRepository: locator.get());

  @override
  void initState() {
    super.initState();
    _bloc.loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<ChatPageBloc, ChatPageState>(
        listener: _blocListener,
        child: BlocBuilder<ChatPageBloc, ChatPageState>(
            bloc: _bloc,
            builder: (context, state) {
              if (state is ChatPageGetDataSuccessState) {
                return Scaffold(
                  appBar: _buildAppBar(),
                  body: _buildBody(state.data),
                );
              } else {
                return Container();
              }
            }),
      ),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      title: CustomText(
        "Furniture Shop",
        fontFamily: FontFamily.gelasio,
        fontSize: FontSize.BIG_1,
      ),
      leading: IconButton(onPressed: () {}, icon: Assets.images.icBack.svg()),
    );
  }

  _blocListener(BuildContext context, ChatPageState state) async {
    print("State $state");
    if (state is ChatPageLoadingState) {
      showLoading();
    } else {
      dismissLoading();
    }
  }

  Widget _buildBody(List<ChatResponseData>? data) {
    if (data != null) {
      return Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDimen.spacing_1),
              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    bool isLastIndex = false;
                    if (index == data.length - 1) {
                      isLastIndex = true;
                    }
                    return Message(
                        message: data[index], isLastIndex: isLastIndex);
                  }),
            ),
          ),
          ChatInputField(),
        ],
      );
    } else
      return Container();
  }
}
