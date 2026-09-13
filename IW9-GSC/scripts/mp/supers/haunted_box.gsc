/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\supers\haunted_box.gsc
***********************************************/

main() {
  level._id_82DFE148CED1F477 = ::_id_82DFE148CED1F477;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    _id_8639626F9311EFCA();
}

_id_8639626F9311EFCA() {
  level._id_9F16330E32BD0097 = spawnStruct();
  level._id_9F16330E32BD0097.enabled = getdvarint("dvar_3824753BD626A50F", 1);

  if(istrue(level._id_9F16330E32BD0097.enabled)) {
    level._id_9F16330E32BD0097._id_01EAB5015307288D = getdvarint("dvar_33C62E743E2C62E2", 1);
    level._id_9F16330E32BD0097._id_98865B0B990C9629 = getdvarfloat("dvar_DEB0777788997FA5", 0.2);
    level._id_9F16330E32BD0097._id_308EF4770401CC00 = ["ingame_haunting_butcher", "ingame_haunting_corpse", "ingame_haunting_death", "ingame_haunting_demon", "ingame_haunting_hands", "ingame_haunting_mummy", "ingame_haunting_possession", "ingame_haunting_teeth", "ingame_haunting_warlock", "ingame_haunting_zombie"];
    thread _id_2F61E64B72DCB65F();
  }

  level._effect["vfx/iw9_br/haunted_box/vfx_haunted_box_dest.vfx"] = loadfx("vfx/iw9_br/haunted_box/vfx_haunted_box_dest.vfx");
  _id_7AB5B649FA408138::_id_0F1AED36AB4598EA("eqp_haunted_box");
}

_id_2F61E64B72DCB65F() {
  level endon("game_ended");
  level waittill("prematch_done");
  level._id_9F16330E32BD0097._id_03C7899636CBA8AB = [];
  level._id_9F16330E32BD0097._id_A679C918818FA808 = strtok(getDvar("dvar_EAD17E29B7D3E5D2", "brloot_plunder_cash_rare_1 brloot_super_stimpistol brloot_killstreak_uav brloot_plate_carrier_tempered brloot_plate_carrier_3_medic"), " ");
  level._id_9F16330E32BD0097._id_011975321CC51CCC = strtok(getDvar("dvar_B38913C76FCA302F", "25 25 15 15 15"), " ");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_9F16330E32BD0097._id_A679C918818FA808.size; _id_AC0E594AC96AA3A8++) {
    _id_1BE58AA13BA9F7DA = spawnStruct();
    _id_1BE58AA13BA9F7DA.scriptablename = level._id_9F16330E32BD0097._id_A679C918818FA808[_id_AC0E594AC96AA3A8];
    _id_1BE58AA13BA9F7DA._id_B9A439CAF48188EF = float(level._id_9F16330E32BD0097._id_011975321CC51CCC[_id_AC0E594AC96AA3A8]);
    _id_1BE58AA13BA9F7DA.count = 1;

    if(_id_7E52B56769FA7774::isplunder(_id_1BE58AA13BA9F7DA.scriptablename) || _id_1BE58AA13BA9F7DA.scriptablename == "brloot_super_stimpistol")
      _id_1BE58AA13BA9F7DA.count = level.br_pickups.counts[_id_1BE58AA13BA9F7DA.scriptablename];

    if(_id_1BE58AA13BA9F7DA.scriptablename == "iw9_lm_dblmg_mp") {
      _id_1BE58AA13BA9F7DA.objweapon = scripts\cp_mp\utility\weapon_utility::_id_EEAA22F0CD1FF845(_id_1BE58AA13BA9F7DA.scriptablename);
      _id_1BE58AA13BA9F7DA.count = weaponclipsize(_id_1BE58AA13BA9F7DA.objweapon);
    }

    level._id_9F16330E32BD0097._id_03C7899636CBA8AB[level._id_9F16330E32BD0097._id_03C7899636CBA8AB.size] = _id_1BE58AA13BA9F7DA;
  }
}

_id_82DFE148CED1F477(player) {
  if(istrue(level._id_9F16330E32BD0097.enabled))
    _id_53905C7899018074(player);

  return 1;
}

_id_53905C7899018074(_id_FBA0376E0036DE8D) {
  if(_id_BDD4C7DB07903046(_id_FBA0376E0036DE8D)) {
    scripts\cp_mp\challenges::_id_8359CADD253F9604(_id_FBA0376E0036DE8D, "jumpscare_box", 1, 0);
    _id_1DCD3D5457634B51(_id_FBA0376E0036DE8D);
  }
}

_id_BDD4C7DB07903046(_id_FBA0376E0036DE8D) {
  if(!istrue(level._id_9F16330E32BD0097._id_01EAB5015307288D))
    return 0;

  if(randomfloat(1.0) > level._id_9F16330E32BD0097._id_98865B0B990C9629)
    return 0;

  return 1;
}

_id_1DCD3D5457634B51(_id_FBA0376E0036DE8D) {
  _id_34A2DD5BBC859C08 = scripts\engine\utility::_id_7A2AAA4A09A4D250(level._id_9F16330E32BD0097._id_308EF4770401CC00);
  _id_450A9D7B25D754D8 = _id_44B8991C2B01716A::_id_0F7FE427D574911C(_id_34A2DD5BBC859C08, _id_FBA0376E0036DE8D, 1, 0);

  if(istrue(_id_450A9D7B25D754D8)) {
    thread _id_1865381550BB926C();
    thread _id_9ADF7587ABC3AF97(_id_FBA0376E0036DE8D);
  }
}

#using_animtree("scriptables");

_id_1865381550BB926C() {
  self endon("death");

  while(isDefined(self) && istrue(self.onuseanimplaying))
    waitframe();

  self setscriptablepartstate("anims", "openJumpscare", 0);
  self.onuseanimplaying = 1;
  wait(getanimlength(%wm_hbox_ground_idle_open_use));
  self setscriptablepartstate("anims", "openIdle", 0);
  self.onuseanimplaying = undefined;
}

_id_9ADF7587ABC3AF97(player) {
  level endon("game_ended");
  self endon("death");
  _id_47230A50F9E752FB = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  _id_6D6F8D51A1B7B6CD = (0, 35, 0);
  _id_C35D9F1ADC6B131F = _id_F4C93829F6081D50(level._id_9F16330E32BD0097._id_03C7899636CBA8AB);
  _id_3163D28D241D4273 = randomfloat(_id_C35D9F1ADC6B131F);
  _id_52F30F2D679B8016 = _id_71BF565567B813E1(level._id_9F16330E32BD0097._id_03C7899636CBA8AB, _id_3163D28D241D4273);
  wait 1.35;
  scripts\mp\equipment\support_box::_id_225B99924F316BC1(_id_47230A50F9E752FB, player, _id_52F30F2D679B8016.scriptablename, _id_52F30F2D679B8016.count, _id_52F30F2D679B8016.objweapon, _id_6D6F8D51A1B7B6CD);
}

_id_F4C93829F6081D50(_id_03C7899636CBA8AB) {
  _id_C35D9F1ADC6B131F = 0.0;

  foreach(_id_1BE58AA13BA9F7DA in _id_03C7899636CBA8AB)
  _id_C35D9F1ADC6B131F = _id_C35D9F1ADC6B131F + _id_1BE58AA13BA9F7DA._id_B9A439CAF48188EF;

  return _id_C35D9F1ADC6B131F;
}

_id_71BF565567B813E1(_id_03C7899636CBA8AB, _id_3163D28D241D4273) {
  _id_C35D9F1ADC6B131F = 0.0;

  foreach(_id_1BE58AA13BA9F7DA in _id_03C7899636CBA8AB) {
    _id_C35D9F1ADC6B131F = _id_C35D9F1ADC6B131F + _id_1BE58AA13BA9F7DA._id_B9A439CAF48188EF;

    if(_id_3163D28D241D4273 <= _id_C35D9F1ADC6B131F)
      return _id_1BE58AA13BA9F7DA;
  }

  return undefined;
}