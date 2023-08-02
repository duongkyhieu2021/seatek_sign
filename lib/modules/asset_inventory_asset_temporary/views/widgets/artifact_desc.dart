import 'package:flutter/material.dart';
import 'package:sea_hr/modules/asset_inventory_asset_temporary/controller/asset_inventory_asset_temporary_controller.dart';
import 'package:sea_hr/widgets/input_widget.dart';

class ArtifactDesc extends StatelessWidget {
  const ArtifactDesc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputWidget(
      labelText: "Mô tả",
      onSaved: (value) => {},
      onChange: (value) {
        AssetInventoryAssetTemporaryController
            .to.currentAssetInventoryAssetTemporary.description = value;
      },
      validator: (value) => null,
      initialValue: AssetInventoryAssetTemporaryController
                  .to.currentAssetInventoryAssetTemporary.description ==
              ""
          ? ""
          : AssetInventoryAssetTemporaryController
              .to.currentAssetInventoryAssetTemporary.description,
    );
  }
}
