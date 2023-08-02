import 'package:flutter/material.dart';
import 'package:sea_hr/modules/asset_inventory_asset_temporary/controller/asset_inventory_asset_temporary_controller.dart';
import 'package:sea_hr/widgets/input_widget.dart';

class ArtifactCodeInput extends StatelessWidget {
  const ArtifactCodeInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputWidget(
      labelText: "Mã code",
      onSaved: (value) => {},
      onChange: (value) {
        AssetInventoryAssetTemporaryController
            .to.currentAssetInventoryAssetTemporary.code = value;
      },
      validator: (value) => null,
      initialValue: AssetInventoryAssetTemporaryController
                  .to.currentAssetInventoryAssetTemporary.code ==
              ""
          ? ""
          : AssetInventoryAssetTemporaryController
              .to.currentAssetInventoryAssetTemporary.code,
    );
  }
}
