/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\killstreaks\cruise_predator_cp.gsc
*************************************************/

init() {
  cruisepredator_createbackupheight();
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B270105ECB28E94BC5CFABAB937D524C5053", "_encstr_86CD1238A8B31A477018B7B5F4D5A3BD2A64C20A", ::cruisepredator_directionoverride);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B270105ECB28E94BC5CFABAB937D524C5053", "_encstr_B86A122B41A713EA82013F4C324630524597523B", ::cruisepredator_aicharacterchecks);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B270105ECB28E94BC5CFABAB937D524C5053", "_encstr_95ED0E76AFEF771BB7F3C53BB1F03703", ::cruisepredator_cpmarkenemies);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B270105ECB28E94BC5CFABAB937D524C5053", "_encstr_8434101E9097085396F380C90AAFDB208F5B", ::cruisepredator_cpunmarkenemies);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B270105ECB28E94BC5CFABAB937D524C5053", "_encstr_B672136E3DEFB08D3FF8D050521F7D480793F96884", ::cruisepredator_removeitemfromslot);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B270105ECB28E94BC5CFABAB937D524C5053", "_encstr_9A54146BDB7AE82C23D1A1CB0AE75D311632E7EB6222", ::initbattleroyalec130airdropcratedata);
}

cruisepredator_directionoverride(var_0) {
  if(isDefined(self.drone_strike_dir_override)) {
    var_0 = anglesToForward(self.drone_strike_dir_override.angles);
    var_0 = vectorNormalize(var_0);
    var_0 = var_0 * (1, 1, 0);
  }

  return var_0;
}

cruisepredator_aicharacterchecks(var_0) {
  if(isai(var_0) || isPlayer(var_0))
    return 1;
  else
    return 0;
}

cruisepredator_createbackupheight() {
  var_0 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", level.mapcenter + (0, 0, 2576));
  var_0.angles = (0, 0, 0);
  var_0.targetname = "_encstr_95D61467465F62ED66084B6BE0D8A5390955ACDF23C1";
  level.vdronestrikeheight = var_0;
}

initbattleroyalec130airdropcratedata(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = level.characters;
  var_4 = [];
  var_5 = level.players;
  var_6 = spawnStruct();

  if(isDefined(level.remote_tanks)) {
    foreach(var_8 in level.remote_tanks) {
      if(isDefined(var_8))
        var_4 = scripts\engine\utility::array_add(var_4, var_8);
    }
  }

  if(isDefined(level.mark_heli) && isDefined(level.heli))
    var_4 = scripts\engine\utility::array_add(var_4, level.heli);

  if(isDefined(level.vo_paratroopers)) {
    foreach(var_11 in level.vo_paratroopers)
    var_4 = scripts\engine\utility::array_add(var_4, var_11);
  }

  foreach(var_14 in var_3) {
    if(level.teambased && var_14.team == var_0.team || var_14 == var_0) {
      var_2[var_2.size] = var_14;
      continue;
    }

    if(cruisepredator_aicharacterchecks(var_14))
      var_1[var_1.size] = var_14;
  }

  var_16 = scripts\engine\utility::array_combine(var_4, var_1);

  foreach(var_14 in var_5) {
    if(level.teambased && var_14.team != var_0.team) {
      continue;
    }
    var_2[var_2.size] = var_14;
  }

  var_6.enemytargetmarkergroup = var_16;
  var_6.friendlytargetmarkergroup = var_2;
  return var_6;
}

cruisepredator_cpmarkenemies(var_0) {
  var_0.enemy_list = [];

  if(isDefined(level.spawned_enemies)) {
    for(var_1 = 0; var_1 < level.spawned_enemies.size; var_1++) {
      level.spawned_enemies[var_1] hudoutlineenableforclient(var_0, "_encstr_8C0316DEABE836A5DCB299B436D8FA19590EE8347DE4B246");
      var_0.enemy_list[var_0.enemy_list.size] = level.spawned_enemies[var_1];
    }
  }

  if(isDefined(level.remote_tanks)) {
    foreach(var_3 in level.remote_tanks) {
      if(isDefined(var_3)) {
        var_3 hudoutlineenableforclient(var_0, "_encstr_8C0316DEABE836A5DCB299B436D8FA19590EE8347DE4B246");
        var_0.enemy_list[var_0.enemy_list.size] = var_3;
      }
    }
  }

  if(isDefined(level.mark_heli) && isDefined(level.heli)) {
    level.heli hudoutlineenableforclient(var_0, "_encstr_8C0316DEABE836A5DCB299B436D8FA19590EE8347DE4B246");
    var_0.enemy_list[var_0.enemy_list.size] = level.heli;
  }

  return var_0.enemy_list;
}

cruisepredator_cpunmarkenemies(var_0) {
  if(isDefined(var_0.enemy_list)) {
    foreach(var_2 in var_0.enemy_list) {
      if(isDefined(var_2))
        var_2 hudoutlinedisableforclient(var_0);
    }
  }
}

cruisepredator_removeitemfromslot(var_0) {
  var_0 scripts\cp\crafting_system::remove_crafted_item_from_slot(scripts\cp\crafting_system::getitemslot("_encstr_8DDA0D2327EDB995D7DC1D4EB4DACA"));
}