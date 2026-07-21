/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: vehicle\empty_turret.gsc
***********************************************/

main(var_0, var_1, var_2) {
  scripts\common\vehicle_build::build_template("_encstr_8C2A0D6F68EF6DE92E0B681D764723", var_0, var_1, var_2);
  scripts\common\vehicle_build::build_localinit(::init_local);
  scripts\common\vehicle_build::build_deathfx("_encstr_BEAA303BC8435618370BB617C3D17A7F9A88F0907C7A26EBD396D0CB98E0C0A718EF02AA2528BD8098FF98F73FEA96BC61DB", undefined, "_encstr_A6351FF8BBF529592B5FB5336893C0F11FA15010D24A79560387C6AE5F376B5902");
  scripts\common\vehicle_build::build_life(200, 180, 230);
  scripts\common\vehicle_build::build_team("_encstr_8E8405EA382B2A");
}

init_local() {
  self.vehicleanimalias = "_encstr_9B2F0F5E952887C6C138F94350157A4F43";
}