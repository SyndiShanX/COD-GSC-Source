/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_326bc91b281ccf55.gsc
***********************************************/

main() {
  setup_callbacks();
  setup_bot_brtdm();
}

setup_callbacks() {
  _id_27FDECE778E999D8::initialize();
  level.bot_funcs["mp_wander_select_destination"] = ::_id_90AA80A0D854DD5D;
}

setup_bot_brtdm() {
  _id_2780B1A6E44F11A0 = level.brtdm_config.spawnorigin["allies"];
  _id_16F22C33F4D4D6DB = level.brtdm_config.spawnorigin["axis"];
  level._id_24991391BA4DCB18 = _func_767CEA82B001F645(_id_2780B1A6E44F11A0 - _id_16F22C33F4D4D6DB);
  level._id_3D6C69CE45DEA7D7 = (_id_2780B1A6E44F11A0 - _id_16F22C33F4D4D6DB) * 0.5 + _id_16F22C33F4D4D6DB;
  level._id_32E9FB0B5827E025 = _func_767CEA82B001F645(level.brtdm_config.circlecenter - level._id_3D6C69CE45DEA7D7);
  level._id_8D51410017E80CD1 = (level.brtdm_config.circleradius - distance2d(level.brtdm_config.circlecenter, level._id_3D6C69CE45DEA7D7)) * 0.8;
  level._id_3FA58CCDBDA67F38 = level._id_8D51410017E80CD1 * 0.2;
}

_id_90AA80A0D854DD5D() {
  _id_332BFCF7ECA6F520 = level._id_3D6C69CE45DEA7D7 + (randomfloat(2) - 1) * level._id_8D51410017E80CD1 * level._id_32E9FB0B5827E025 + (randomfloat(2) - 1) * level._id_3FA58CCDBDA67F38 * level._id_24991391BA4DCB18;
  contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1);
  _id_332BFCF7ECA6F520 = scripts\engine\utility::drop_to_ground((_id_332BFCF7ECA6F520[0], _id_332BFCF7ECA6F520[1], 4000), undefined, undefined, undefined, contents);
  _id_332BFCF7ECA6F520 = _id_59FF79D681BB860C::_id_207BA502560FA1D2(_id_332BFCF7ECA6F520);
  return _id_332BFCF7ECA6F520;
}