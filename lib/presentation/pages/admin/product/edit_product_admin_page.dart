import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furniture_shop/generated/assets/assets.gen.dart';
import 'package:furniture_shop/generated/assets/fonts.gen.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_appbar.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_textfield.dart';
import 'package:furniture_shop/presentation/widgets/custom_outline_input.dart';
import 'package:furniture_shop/presentation/widgets/primary_button.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

final List<String> items = ['Lamp', 'Chair', 'Arm Chair', 'TV', 'Bed'];

enum EditAdminType {
  New,
  Edit,
}

class EditAdminProductPage extends StatefulWidget {
  final EditAdminType typeEdit;

  const EditAdminProductPage({
    this.typeEdit = EditAdminType.New,
    Key? key,
  }) : super(key: key);

  @override
  State<EditAdminProductPage> createState() => _EditAdminProductPageState();
}

class _EditAdminProductPageState extends State<EditAdminProductPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController categoryController;
  late TextEditingController priceController;
  late TextEditingController quantityController;
  late TextEditingController descriptionController;
  String chooseValue = items[2];

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController();
    categoryController = TextEditingController();
    priceController = TextEditingController();
    quantityController = TextEditingController();
    descriptionController = TextEditingController();
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
      body: SingleChildScrollView(
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
      ),
      bottomNavigationBar: _buildButton(),
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
            onPressed: () {},
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
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return _buildCustomImage();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCustomImage() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 200,
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimen.radiusNormal),
        image: DecorationImage(
          image: AssetImage(Assets.images.imgChair.path),
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
