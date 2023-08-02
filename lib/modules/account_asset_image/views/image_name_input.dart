import 'package:flutter/widgets.dart';
import 'package:sea_hr/modules/account_asset_image/controller/account_asset_image_controller.dart';
import 'package:sea_hr/widgets/input_widget.dart';

class ImageNameInput extends StatelessWidget {
  const ImageNameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputWidget(
      labelText: "Ghi chú",
      hintText: "Ghi chú",
      onSaved: (value) => {},
      onChange: (value) {
        AccountAssetImageController
            .to.currentAccountAssetImage.value.assetFilename = value;
      },
      validator: (value) => null,
      initialValue: AccountAssetImageController
              .to.currentAccountAssetImage.value.assetFilename ??
          "",
    );
  }
}
