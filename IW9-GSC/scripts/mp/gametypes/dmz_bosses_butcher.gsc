/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\dmz_bosses_butcher.gsc
*******************************************************/

main() {
  gametype = scripts\cp_mp\utility\game_utility::_id_6C1FCE6F6B8779D5();
  scripts\cp_mp\utility\script_utility::registersharedfunc("ai", "dropLootOnAgentDeath", _id_48814951E916AF89::_id_82ED67AE79913551);

  if(_id_2C3C990BA58FA6F5::_id_364F4C40FF756CAC())
    level thread _id_59EBFABF2131C30F::_id_C3D723A43ACE2916();
}

_id_47BD9E7F3C47BDF8() {
  if(!_id_59EBFABF2131C30F::_id_6FBDD8615F9428B6()) {
    return;
  }
  _id_AED74300DAF62896 = spawnStruct();
  _id_AED74300DAF62896.armor = getdvarfloat("dvar_4CFC08C2C09CC4DA", 5000);
  _id_AED74300DAF62896.maxdamage = getdvarint("dvar_7B0F15773F96AAA0", 100);
  _id_AED74300DAF62896._id_BFE291B401A9BF2A = [];
  _id_AED74300DAF62896.name = "butcher";
  _id_AED74300DAF62896._id_649245B52DBF88A9 = undefined;
  _id_AED74300DAF62896._id_EC2EC5F083DF61CD = _id_59EBFABF2131C30F::_id_0007510DB499B9CB;
  _id_AED74300DAF62896.spawnfunc = _id_59EBFABF2131C30F::_id_322482F38CB4A256;
  _id_AED74300DAF62896._id_E68429B39C75B6EE = _id_59EBFABF2131C30F::_id_6D69350C86BAF67B;
  _id_AED74300DAF62896._id_7232C52496C3A94A = _id_59EBFABF2131C30F::_id_F9B85A83346B7743;
  _id_2FDEB8023287BE67::_id_469ECEAE21900C7D(_id_AED74300DAF62896, "haunting", 1);
  _id_2FDEB8023287BE67::_id_613E13E7416BFAA5(_id_AED74300DAF62896);
}