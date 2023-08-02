import 'package:flutter/material.dart';
import 'package:sea_hr/modules/asset_inventory_asset_temporary/controller/asset_inventory_asset_temporary_controller.dart';
import 'package:sea_hr/widgets/input_widget.dart';

class ArtifactNameInput extends StatelessWidget {
  const ArtifactNameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputWidget(
      labelText: "Tên hiện vật",
      onSaved: (value) => {},
      onChange: (value) {
        AssetInventoryAssetTemporaryController
            .to.currentAssetInventoryAssetTemporary.name = value;
      },
      validator: (value) => null,
      initialValue: AssetInventoryAssetTemporaryController
                  .to.currentAssetInventoryAssetTemporary.name ==
              ""
          ? ""
          : AssetInventoryAssetTemporaryController
              .to.currentAssetInventoryAssetTemporary.name,
    );
  }
}
