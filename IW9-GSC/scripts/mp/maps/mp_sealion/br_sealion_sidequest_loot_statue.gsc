/***************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_sealion\br_sealion_sidequest_loot_statue.gsc
***************************************************************************/

main() {
  thread _id_DEEE3B97BF9C0945();
}

_id_DEEE3B97BF9C0945() {
  waitframe();

  if(!scripts\cp_mp\utility\game_utility::_id_E21746ABAAAF8414()) {
    return;
  }
  init();
}

init() {
  if(!getdvarint("dvar_DC22C2DA086230DF", 0)) {
    return;
  }
  _id_618A1163576C3819();
  _id_43F3DE04ECBC94D4();
  _id_72132D53E4D2D267();
}

_id_618A1163576C3819() {
  level._id_C0CCE2007FDC9417 = spawnStruct();
  level._id_C0CCE2007FDC9417._id_28A0737B99AC5E40 = [];
  level._id_C0CCE2007FDC9417._id_31CC42579452811F = getdvarint("dvar_52439477A985E842", 3);
  level._id_C0CCE2007FDC9417._id_7366DF7246AA6A8E = getdvarint("dvar_4B1F8EFE546A3623", 7);
  level._id_C0CCE2007FDC9417._id_AA24CB82F2DC3206 = getdvarint("dvar_FB987D1C2574394D", 15);
}

_id_43F3DE04ECBC94D4() {
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("scriptable_sealion_loot_statue", ::_id_4E95355684CF2CAB);

  switch (level.mapname) {
    case "mp_sealion":
      spawnscriptable("scriptable_sealion_loot_statue", (-9825, 2276, 500), (0, 11, 0));
      break;
    default:
      break;
  }
}

_id_72132D53E4D2D267() {
  level._id_C0CCE2007FDC9417._id_39244964BE288ED7 = ["brloot_offhand_frag", "brloot_offhand_semtex", "brloot_offhand_claymore", "brloot_super_munitionsbox", "brloot_super_armorbox", "brloot_super_emppulse", "brloot_super_tacticalcamera"];
  level._id_C0CCE2007FDC9417._id_705ECB24F274D0D2 = ["brloot_killstreak_clusterstrike", "brloot_killstreak_cluster_spike", "brloot_killstreak_precision_airstrike"];
  level._id_C0CCE2007FDC9417._id_35786F551F040FCA = ["high_wep"];

  if(getdvarint("dvar_9264F8F1143934C6", 0) && _id_55E418C5CC946593::_id_2980F22FB01F43E6())
    level._id_C0CCE2007FDC9417._id_35786F551F040FCA = scripts\engine\utility::array_add(level._id_C0CCE2007FDC9417._id_35786F551F040FCA, "perk_pack");

  if(getdvarint("dvar_368EA569C1A6A4E4", 1))
    level._id_C0CCE2007FDC9417._id_35786F551F040FCA = scripts\engine\utility::array_add(level._id_C0CCE2007FDC9417._id_35786F551F040FCA, "plate_carrier");
}

_id_4E95355684CF2CAB(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!isDefined(level._id_C0CCE2007FDC9417._id_A1D6F6B65E7A4824))
    level._id_C0CCE2007FDC9417._id_A1D6F6B65E7A4824 = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7("brloot_sealion_sidequest_fish");

  if(!player _id_2D9D24F7C63AC143::_id_6F39F9916649AC48(level._id_C0CCE2007FDC9417._id_A1D6F6B65E7A4824, 1)) {
    return;
  }
  if(!isDefined(level._id_C0CCE2007FDC9417._id_28A0737B99AC5E40[player.team]))
    level._id_C0CCE2007FDC9417._id_28A0737B99AC5E40[player.team] = 1;
  else
    level._id_C0CCE2007FDC9417._id_28A0737B99AC5E40[player.team]++;

  instance thread _id_54B191A8BCF916C4(player);
}

_id_54B191A8BCF916C4(player) {
  level endon("game_ended");
  self setscriptablepartstate("scriptable_sealion_loot_statue", "eating");
  wait 0.75;
  _id_9383BBB771C503F8 = level._id_C0CCE2007FDC9417._id_28A0737B99AC5E40[player.team] % level._id_C0CCE2007FDC9417._id_31CC42579452811F == 0;
  _id_EC96F6A23445A89F = level._id_C0CCE2007FDC9417._id_28A0737B99AC5E40[player.team] % level._id_C0CCE2007FDC9417._id_7366DF7246AA6A8E == 0;
  _id_01BD86FDC33EB8BF = level._id_C0CCE2007FDC9417._id_28A0737B99AC5E40[player.team] % level._id_C0CCE2007FDC9417._id_AA24CB82F2DC3206 == 0;

  if(_id_9383BBB771C503F8 || _id_EC96F6A23445A89F || _id_01BD86FDC33EB8BF) {
    self setscriptablepartstate("scriptable_sealion_loot_statue", "dispensing");
    wait 1.5;

    if(!isDefined(self._id_F5246583F81E13B0))
      self._id_F5246583F81E13B0 = self.origin + anglesToForward(self.angles) * 30;

    dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();

    if(_id_9383BBB771C503F8) {
      _id_D8CD9C1941A88194 = scripts\engine\utility::_id_7A2AAA4A09A4D250(level._id_C0CCE2007FDC9417._id_39244964BE288ED7);
      _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, self._id_F5246583F81E13B0, self.angles, undefined, level.br_pickups._id_AD49A38DD7C4C10F, level.br_pickups._id_3B53BC0EEE6AE84E);
      _id_7E52B56769FA7774::spawnpickup(_id_D8CD9C1941A88194, _id_CB4FAD49263E20C4, 1, 1);
    }

    if(_id_EC96F6A23445A89F) {
      _id_D8CD9C1941A88194 = scripts\engine\utility::_id_7A2AAA4A09A4D250(level._id_C0CCE2007FDC9417._id_705ECB24F274D0D2);
      _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, self._id_F5246583F81E13B0, self.angles, undefined, level.br_pickups._id_AD49A38DD7C4C10F, level.br_pickups._id_3B53BC0EEE6AE84E);
      _id_7E52B56769FA7774::spawnpickup(_id_D8CD9C1941A88194, _id_CB4FAD49263E20C4, 1, 1);
    }

    if(_id_01BD86FDC33EB8BF) {
      item = scripts\engine\utility::_id_7A2AAA4A09A4D250(level._id_C0CCE2007FDC9417._id_35786F551F040FCA);

      if(item == "high_wep")
        item = pickscriptablelootitem("weapon", 4, 4, "mp/loot/br/default/lootset_cache_lege.csv");
      else if(item == "perk_pack")
        item = scripts\engine\utility::_id_7A2AAA4A09A4D250(["brloot_perkpack_beret_br", "brloot_perkpack_insurgent_br", "brloot_perkpack_demolitionist_br", "brloot_perkpack_reserves_br", "brloot_perkpack_swat_br"]);
      else if(item == "plate_carrier")
        item = scripts\engine\utility::_id_7A2AAA4A09A4D250(["brloot_plate_carrier_tempered"]);

      _id_EA156F5F477A8792 = 1;

      if(isDefined(level.br_lootiteminfo[item])) {
        weapon = _id_7E52B56769FA7774::getfullweaponobjfromscriptablename(item);
        _id_EA156F5F477A8792 = weaponclipsize(weapon);
      }

      _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, self._id_F5246583F81E13B0, self.angles, undefined, level.br_pickups._id_AD49A38DD7C4C10F, level.br_pickups._id_3B53BC0EEE6AE84E);
      _id_7E52B56769FA7774::spawnpickup(item, _id_CB4FAD49263E20C4, _id_EA156F5F477A8792, 1);
    }

    player scripts\mp\utility\points::_id_0366980B6A8796AE("stat_86488C527D59A467");
  } else
    player scripts\mp\utility\points::_id_0366980B6A8796AE("stat_758317CA2873C88A");

  self setscriptablepartstate("scriptable_sealion_loot_statue", "usable");
}