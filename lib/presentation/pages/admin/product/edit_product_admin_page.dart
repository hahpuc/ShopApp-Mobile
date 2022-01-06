import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:furniture_shop/common/mixins/after_layout.dart';
import 'package:furniture_shop/configs/service_locator.dart';
import 'package:furniture_shop/generated/assets/assets.gen.dart';
import 'package:furniture_shop/generated/assets/fonts.gen.dart';
import 'package:furniture_shop/presentation/pages/admin/product/edit_product_bloc.dart';
import 'package:furniture_shop/presentation/pages/admin/product/edit_product_state.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_appbar.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_textfield.dart';
import 'package:furniture_shop/presentation/widgets/custom_outline_input.dart';
import 'package:furniture_shop/presentation/widgets/primary_button.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

final List<String> items = ['Desk', 'Chair', 'Lamp', 'Bed', 'Tv'];

enum EditAdminType {
  New,
  Edit,
}

final List<String> images = [
  "http://res.cloudinary.com/dynk5q1io/image/upload/v1634120352/products/Gaming%20Table/axmlvoybwtp7xekzz6eq.jpg",
  "http://res.cloudinary.com/dynk5q1io/image/upload/v1634120354/products/Gaming%20Table/z36qyy9awic0eltow6qi.jpg",
  "http://res.cloudinary.com/dynk5q1io/image/upload/v1634120357/products/Gaming%20Table/g9xxtp6mtfdmh00kosmt.jpg",
];

class EditAdminProductPage extends StatefulWidget {
  final EditAdminType typeEdit;

  const EditAdminProductPage({
    this.typeEdit = EditAdminType.New,
    Key? key,
  }) : super(key: key);

  @override
  State<EditAdminProductPage> createState() => _EditAdminProductPageState();
}

class _EditAdminProductPageState extends State<EditAdminProductPage>
    with AfterLayoutMixin {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController categoryController;
  late TextEditingController priceController;
  late TextEditingController quantityController;
  late TextEditingController descriptionController;
  String chooseValue = items[0];

  EditProductBloc _bloc = EditProductBloc(appRepository: locator.get());

  @override
  void afterFirstFrame(BuildContext context) {
    _bloc.getProductDetailsData();
  }

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController();
    categoryController = TextEditingController();
    priceController = TextEditingController();
    quantityController = TextEditingController();
    descriptionController = TextEditingController();

    nameController.text = 'Gaming Table Ver3';
    priceController.text = '5500000';
    quantityController.text = '0';
    descriptionController.text =
        'Table Mouse Pad, Gaming Computer Desk, 63 in, Black';
  }

  @override
  void dispose() {
    nameController.dispose();
    categoryController.dispose();
    priceController.dispose();
    quantityController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: CustomText(
        widget.typeEdit == EditAdminType.New ? 'Add product' : 'Update product',
        fontSize: FontSize.BIG_1,
        fontFamily: FontFamily.gelasio,
      )),
      body: _buildBody(),
      bottomNavigationBar: _buildButton(),
    );
  }

  _blocListener(BuildContext context, EditProductState state) async {
    print("State $state");
    if (state is EditProductLoadingState) {
      EasyLoading.show(status: 'loading', maskType: EasyLoadingMaskType.black);
    } else {
      EasyLoading.dismiss();
    }

    if (state is UpdateProductSuccessState) {
      EasyLoading.showSuccess('Update product success');
    }
  }

  Widget _buildBody() {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<EditProductBloc, EditProductState>(
        listener: _blocListener,
        child: BlocBuilder<EditProductBloc, EditProductState>(
          bloc: _bloc,
          builder: (context, state) {
            if (state is EditProductGetDataSuccess ||
                state is UpdateProductSuccessState) {
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimen.spacing_1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInput(),
                        _buildDescription(),
                        _buildImages(),
                      ],
                    ),
                  ),
                ),
              );
            }

            return Container();
          },
        ),
      ),
    );
  }

  Widget _buildButton() {
    switch (widget.typeEdit) {
      case EditAdminType.Edit:
        return Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(
            vertical: AppDimen.verticalSpacing,
            horizontal: AppDimen.horizontalSpacing + 4,
          ),
          child: PrimaryButton(
            title: 'Update',
            onPressed: () {
              setState(() {});
              _bloc.updateProduct();
            },
          ),
        );
      default:
        return Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(
            vertical: AppDimen.verticalSpacing,
            horizontal: AppDimen.horizontalSpacing + 4,
          ),
          child: PrimaryButton(
            title: 'Add new product',
            onPressed: () {},
          ),
        );
    }
  }

  Widget _buildInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomOutlineInput(
          margin: const EdgeInsets.symmetric(
            vertical: AppDimen.spacing_1,
          ),
          child: CustomTextField(
            textController: nameController,
            labelText: 'Product name',
          ),
        ),
        CustomOutlineInput(
          title: 'Category',
          child: DropdownButton(
            elevation: 0,
            isExpanded: true,
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.black,
            ),
            underline: const SizedBox(),
            items: items
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: CustomText(item),
                    ))
                .toList(),
            value: chooseValue,
            onChanged: (newValue) {
              setState(() {
                chooseValue = newValue.toString();
              });
            },
          ),
        ),
        CustomOutlineInput(
          margin: const EdgeInsets.symmetric(
            vertical: AppDimen.spacing_1,
          ),
          child: CustomTextField(
            textController: priceController,
            labelText: 'Price',
          ),
        ),
        CustomOutlineInput(
          margin: const EdgeInsets.symmetric(
            vertical: AppDimen.spacing_1,
          ),
          child: CustomTextField(
            textController: quantityController,
            labelText: 'Quantity',
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle('Description'),
        CustomOutlineInput(
          backgroundColor: AppColor.colorGreyLight,
          child: CustomTextField(
            textController: descriptionController,
            textColor: AppColor.colorPrimary,
            maxLines: 7,
          ),
        ),
      ],
    );
  }

  Widget _buildImages() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle('Images'),
        Container(
          height: 200,
          child: ListView.builder(
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return _buildCustomImage(index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCustomImage(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 200,
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimen.radiusNormal),
        image: DecorationImage(
          image: NetworkImage(images[index]),
          //   image: AssetImage(Assets.images.imgChair.path),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(Assets.images.icCloseCircle.path),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(String title) {
    return CustomText(
      title,
      color: AppColor.colorGrey,
      fontSize: FontSize.SMALL,
      margin: const EdgeInsets.symmetric(vertical: AppDimen.spacing_2),
    );
  }
}
