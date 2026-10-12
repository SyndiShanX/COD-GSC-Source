/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_42adcce5878f583.gsc
************************************************/

#using script_24946c036cb2f7b2;
#using script_3ab210ea917601e7;
#using scripts\cp_mp\zombie_challenges;
#using scripts\anim\dialogue;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\utility;
#namespace namespace_cc63b8cc61c0499b;

function function_d0b51f1ea60e958b(players, var_5a6e3a10171c93b) {
  if(!isDefined(players) || !isarray(players) || players.size == 0) {
    return;
  }

  if(istrue(var_5a6e3a10171c93b)) {
    function_1281c7fff9456e18("warlord_vo_proximity_entered_alt", players);
    return;
  }

  function_1281c7fff9456e18("warlord_vo_proximity_entered", players);
}

function function_9c1b6cb8cff3ac15(players) {
  if(!isDefined(players) || !isarray(players) || players.size == 0) {
    return;
  }

  function_1281c7fff9456e18("warlord_vo_proximity_exited", players);
}

function function_71171b28ba5738df(players) {
  if(!isDefined(players) || !isarray(players) || players.size == 0) {
    return;
  }

  var_694cf27a7080216 = [];

  foreach(player in players) {
    if(!isDefined(player) || array_contains(var_694cf27a7080216, player)) {
      continue;
    }

    if(namespace_838b439602b3acc7::function_5acc35fc66331385(player, 17078) || getdvarint(@ "hash_7b8b09c504a0c9a0", 0)) {
      params = spawnStruct();
      params.player = player;
      params.is_warlord = 1;
      callback::callback("on_approach_merc_stronghold", params);
      squadmembers = player scripts\cp_mp\utility\squad_utility::getsquadmembers();

      foreach(squadmember in squadmembers) {
        var_694cf27a7080216[var_694cf27a7080216.size] = squadmember;
      }
    }
  }

  foreach(player in players) {
    if(!isDefined(player) || array_contains(var_694cf27a7080216, player)) {
      continue;
    }

    function_1281c7fff9456e18("warlord_vo_handler_intro", [player]);
  }
}

function function_65175e987bbfc6f8(players) {
  if(!isDefined(players) || !isarray(players) || players.size == 0) {
    return;
  }

  function_1281c7fff9456e18("warlord_vo_handler_outro", players);
}

function function_bf1a19db888d229f(players) {
  level endon("game_ended");

  if(!isDefined(players) || !isarray(players) || players.size == 0) {
    return 0;
  }

  return namespace_9718b9a169c3ead0::function_a7679b1e7a48f91("warlord_vo_death", players, 1);
}

function function_d13aa6af7fce67c9(players) {
  if(!isDefined(players) || !isarray(players) || players.size == 0) {
    return;
  }

  function_1281c7fff9456e18("warlord_vo_fight_begins", players);
}

function function_49a282654ffb7685(squad) {
  if(!isDefined(squad) || !isarray(squad) || squad.size == 0) {
    return;
  }

  thread namespace_9718b9a169c3ead0::function_43007b614b2eb884("warlord_vo_no_fortress_key", squad, 300);
}

function function_53bd256d9112a4e3() {
  level endon("game_ended");
  self endon("activity_ended");
  self endon("instance_destroyed");

  if(!isDefined(self.warlord_agent)) {
    self waittill("warlord_spawned");
  }

  assert(isDefined(self.warlord_agent));
  self.warlord_agent ent_flag_set("warlord_start_combat_chatter");
}

function function_70d2561024bc73f4(warlordtype, cooldownseconds, var_41ecd282cbd8319a, var_651c4bb853d4df1f) {
  if(!isDefined(self)) {
    return;
  }

  assert(isDefined(warlordtype));
  assert(isDefined(cooldownseconds));
  assert(isDefined(var_41ecd282cbd8319a));
  assert(isDefined(var_651c4bb853d4df1f));
  level endon("game_ended");
  self endon("death");
  self notify("warlord_combat_chatter_stop");
  self endon("warlord_combat_chatter_stop");
  self.var_50cf411802ee43ce = spawnStruct();
  self.var_50cf411802ee43ce.var_9c3f4df602c70997 = undefined;
  self.var_50cf411802ee43ce.var_d4d48422d1660504 = undefined;
  self.var_50cf411802ee43ce.var_5fa7de1d4e75d893 = cooldownseconds * 1000;
  self.var_50cf411802ee43ce.var_111072f2a4205196 = [];
  self.var_50cf411802ee43ce.var_3231bfdeb1f1382c = function_d7662087b637a517(warlordtype);
  childthread function_51642efaa3c1ea81("TAUNTS", var_41ecd282cbd8319a);
  childthread function_51642efaa3c1ea81("BARKS_TO_GUARDS", var_651c4bb853d4df1f);

  if(warlordtype != "AllForOne") {
    function_186c5399d7bd519c();
  }

  function_334a07b624825ca5();

  childthread function_bb1d5509c601171a();
  function_78ea414bb61b846c("<dev string:x1c>" + warlordtype);
}

function function_9488f02028f9f413(warlordtype) {
  return isDefined(warlordtype) && (warlordtype == "Chemist" || warlordtype == "Maestro" || warlordtype == "AllForOne" || warlordtype == "Rainmaker");
}

function function_d7662087b637a517(warlordtype) {
  aliases = [];

  switch (warlordtype) {
    case #"hash_85cbb30164805d78":
      aliases["TAUNTS"] = ["dx_ob_wrls_taun_cmst_keeptheminthefogincr", "dx_ob_wrls_taun_cmst_allinthenameofscienc", "dx_ob_wrls_taun_cmst_theseareexcellentres"];
      aliases["BARKS_TO_GUARDS"] = ["dx_ob_wrls_batg_cmst_makethemcometous", "dx_ob_wrls_batg_cmst_letthegasdothework", "dx_ob_wrls_batg_cmst_drawthemcloser"];
      aliases["BEHAVIOR1"] = ["dx_ob_wrls_beh1_cmst_theycantfightiftheyc", "dx_ob_wrls_beh1_cmst_deployingtoxins", "dx_ob_wrls_beh1_cmst_youcantholdyourbreat"];
      aliases["BEHAVIOR2"] = ["dx_ob_wrls_beh2_cmst_subjectsuccessfullye", "dx_ob_wrls_beh2_cmst_effectsimmediateeven", "dx_ob_wrls_beh2_cmst_theyreweakeningkeept"];
      aliases["BEHAVIOR3"] = ["dx_ob_wrls_beh3_cmst_removeyourmaskyoucow", "dx_ob_wrls_beh3_cmst_theirmaskswillfailso", "dx_ob_wrls_beh3_cmst_holdpositionuntilthe"];
      break;
    case #"hash_4cef1fb79bcf6a86":
      aliases["TAUNTS"] = ["dx_ob_wrls_taun_tmst_stopwastingmytime", "dx_ob_wrls_taun_tmst_ilikemovingtargets", "dx_ob_wrls_taun_tmst_illaddyoutomykillcou"];
      aliases["BARKS_TO_GUARDS"] = ["dx_ob_wrls_batg_tmst_pushthemback", "dx_ob_wrls_batg_tmst_takethemout", "dx_ob_wrls_batg_tmst_destroythem"];
      aliases["BEHAVIOR1"] = ["dx_ob_wrls_beh1_tmst_deployingdrones", "dx_ob_wrls_beh2_tmst_letsseehowyoudoagain", "dx_ob_wrls_beh1_tmst_dronesarehot"];
      aliases["BEHAVIOR2"] = ["dx_ob_wrls_beh2_tmst_alldronesacquiretarg", "dx_ob_wrls_beh1_tmst_huntthemdown", "dx_ob_wrls_beh2_tmst_dronessearchanddestr"];
      aliases["BEHAVIOR3"] = ["dx_ob_wrls_beh3_tmst_didntthinkidseeyouag", "dx_ob_wrls_beh3_tmst_ohwowyourestillhere", "dx_ob_wrls_beh3_tmst_letsfinishthis"];
      aliases["BEHAVIOR4"] = ["dx_ob_wrls_esca_tmst_youresuchabuzzkill", "dx_ob_wrls_esca_tmst_youresuchabuzzkill_01", "dx_ob_wrls_esca_tmst_youresuchabuzzkill_02"];
      break;
    case #"hash_11b902bfab970489":
      aliases["TAUNTS"] = ["dx_ob_wrls_taun_alfo_areyouwillingtogivey", "dx_ob_wrls_taun_alfo_faceityoureoutmatche", "dx_ob_wrls_taun_alfo_yourenotsotough_01"];
      aliases["BARKS_TO_GUARDS"] = ["dx_ob_wrls_batg_alfo_theyshouldbedeadbyno", "dx_ob_wrls_batg_alfo_whydotheystillbreath", "dx_ob_wrls_batg_alfo_dontletemgaingroundp"];
      aliases["BEHAVIOR1"] = ["dx_ob_wrls_beh1_alfo_nowyoullseewhatyoure", "dx_ob_wrls_beh1_alfo_dontletthemleavehere", "dx_ob_wrls_beh1_alfo_yourefacingoverwhelm"];
      aliases["BEHAVIOR2"] = ["dx_ob_wrls_beh2_alfo_instantsunshine", "dx_ob_wrls_beh2_alfo_flash"];
      aliases["BEHAVIOR3"] = ["dx_ob_wrls_beh3_alfo_callinginairsupport", "dx_ob_wrls_beh3_alfo_ineedairsupportnow", "dx_ob_wrls_beh3_alfo_requestingcloseair"];
      var_d542ab744b6e7d1c = array_random(aliases["BARKS_TO_GUARDS"]);
      aliases["BEHAVIOR4"] = [var_d542ab744b6e7d1c];
      aliases["BARKS_TO_GUARDS"] = array_remove(aliases["BARKS_TO_GUARDS"], var_d542ab744b6e7d1c);
      break;
    case #"hash_57ced1fd426a2449":
      aliases["TAUNTS"] = ["dx_ob_wrls_taun_rmkr_illenjoywatchingyoud", "dx_ob_wrls_taun_rmkr_everseenabodyvaporiz", "dx_ob_wrls_taun_rmkr_isthisreallyallyougo"];
      aliases["BARKS_TO_GUARDS"] = ["dx_ob_wrls_batg_rmkr_letemhaveit", "dx_ob_wrls_batg_rmkr_shownomercy", "dx_ob_wrls_batg_rmkr_wipethemoffthemap"];
      aliases["BEHAVIOR1"] = ["dx_ob_wrls_beh1_rmkr_fireeverythingyouveg", "dx_ob_wrls_beh1_rmkr_thisismyisland", "dx_ob_wrls_beh1_rmkr_dontletthemthrough"];
      aliases["BEHAVIOR2"] = ["dx_ob_wrls_beh2_rmkr_whywontyoudie", "dx_ob_wrls_beh2_rmkr_clusterminesout", "dx_ob_wrls_beh2_rmkr_heypingawatchyourste"];
      aliases["BEHAVIOR3"] = ["dx_ob_wrls_beh3_rmkr_illblowyoutopiecesco", "dx_ob_wrls_beh3_rmkr_loveagoodexplosion", "dx_ob_wrls_beh3_rmkr_iwillendyoupunenta"];
      break;
    default:
      assertmsg("<dev string:x42>");
      break;
  }

  return aliases;
}

function function_186c5399d7bd519c() {
  self notify("start_warlord_combat_looping_chatter_" + "BARKS_TO_GUARDS");
}

function function_334a07b624825ca5() {
  self notify("start_warlord_combat_looping_chatter_" + "TAUNTS");
}

function private function_51642efaa3c1ea81(category, cooldownseconds) {
  if(!isDefined(category) || !isDefined(self.var_50cf411802ee43ce.var_3231bfdeb1f1382c[category]) || self.var_50cf411802ee43ce.var_3231bfdeb1f1382c[category].size == 0) {
    return;
  }

  assert(isDefined(cooldownseconds) && cooldownseconds > 0);
  self waittill("start_warlord_combat_looping_chatter_" + category);

  while(true) {
    wait cooldownseconds;
    thread function_93caad88720d8064(category);
  }
}

function private function_93caad88720d8064(category, contextentity, overridecooldown) {
  if(!isDefined(category)) {
    function_78ea414bb61b846c("<dev string:x71>");

    return false;
  }

  if(!isDefined(self) || !isDefined(self.var_50cf411802ee43ce) || !isDefined(self.var_50cf411802ee43ce.var_3231bfdeb1f1382c)) {
    function_78ea414bb61b846c("<dev string:x9f>" + category + "<dev string:xaf>");

    return false;
  }

  aliases = self.var_50cf411802ee43ce.var_3231bfdeb1f1382c[category];

  if(!isDefined(aliases) || !isarray(aliases) || aliases.size == 0) {
    function_78ea414bb61b846c("<dev string:x9f>" + category + "<dev string:xde>");

    return false;
  }

  alias = array_random(aliases);

  if(!isDefined(alias)) {
    function_78ea414bb61b846c("<dev string:x9f>" + category + "<dev string:x105>");

    return false;
  }

  if(isDefined(self.var_50cf411802ee43ce.var_d4d48422d1660504)) {
    function_78ea414bb61b846c("<dev string:x9f>" + category + "<dev string:x125>");

    return false;
  }

  if(!istrue(overridecooldown) && isDefined(self.var_50cf411802ee43ce.var_9c3f4df602c70997) && isDefined(self.var_50cf411802ee43ce.var_5fa7de1d4e75d893)) {
    if(self.var_50cf411802ee43ce.var_9c3f4df602c70997 + self.var_50cf411802ee43ce.var_5fa7de1d4e75d893 > gettime()) {
      function_78ea414bb61b846c("<dev string:x9f>" + category + "<dev string:x150>");

      return false;
    }
  }

  if(isDefined(contextentity) && function_841c15d31f2a24d6(category, contextentity)) {
    function_78ea414bb61b846c("<dev string:x9f>" + category + "<dev string:x177>");

    return false;
  }

  level endon("game_ended");
  self endon("death");
  self endon("warlord_combat_chatter_stop");
  self.var_50cf411802ee43ce.var_d4d48422d1660504 = alias;

  self.var_50cf411802ee43ce.activecategory = category;

  chatterstarttime = gettime();
  result = scripts\anim\dialogue::say(alias);

  if(istrue(result)) {
    self.var_50cf411802ee43ce.var_9c3f4df602c70997 = chatterstarttime;
    self.var_50cf411802ee43ce.var_3231bfdeb1f1382c[category] = array_remove(self.var_50cf411802ee43ce.var_3231bfdeb1f1382c[category], alias);
    function_460355d1f69f76e1(category, contextentity);

    function_78ea414bb61b846c("<dev string:x9f>" + category + "<dev string:x1b7>" + alias);
  } else {
    function_78ea414bb61b846c("<dev string:x9f>" + category + "<dev string:x1d1>");
  }

  self.var_50cf411802ee43ce.var_d4d48422d1660504 = undefined;
  return istrue(result);
}

function private function_841c15d31f2a24d6(category, contextentity) {
  if(!isDefined(self) || !isDefined(self.var_50cf411802ee43ce) || !isDefined(contextentity) || !isDefined(category)) {
    return 0;
  }

  if(!isDefined(self.var_50cf411802ee43ce.var_111072f2a4205196) || !isDefined(self.var_50cf411802ee43ce.var_111072f2a4205196[category])) {
    return 0;
  }

  return array_contains(self.var_50cf411802ee43ce.var_111072f2a4205196[category], contextentity);
}

function private function_460355d1f69f76e1(category, contextentity) {
  if(!isDefined(self) || !isDefined(self.var_50cf411802ee43ce) || !isDefined(contextentity) || !isDefined(category)) {
    return;
  }

  if(!isDefined(self.var_50cf411802ee43ce.var_111072f2a4205196)) {
    self.var_50cf411802ee43ce.var_111072f2a4205196 = [];
  }

  if(!isDefined(self.var_50cf411802ee43ce.var_111072f2a4205196[category])) {
    self.var_50cf411802ee43ce.var_111072f2a4205196[category] = [];
  }

  self.var_50cf411802ee43ce.var_111072f2a4205196[category] = array_add(self.var_50cf411802ee43ce.var_111072f2a4205196[category], contextentity);
}

function function_f096dea082480f5() {
  if(isDefined(self) && isalive(self)) {
    thread function_93caad88720d8064("BEHAVIOR1");
  }
}

function function_4e8e1867968e84a5(player) {
  if(isDefined(self) && isalive(self)) {
    thread function_93caad88720d8064("BEHAVIOR2", player);
  }
}

function function_7f0a446fa91ff206(player) {
  if(isDefined(self) && isalive(self)) {
    thread function_93caad88720d8064("BEHAVIOR3", player);
  }
}

function function_d01822693171d7c1() {
  if(isDefined(self) && isalive(self)) {
    thread function_93caad88720d8064("BEHAVIOR1");
  }
}

function function_85d8080b6082da5f() {
  if(isDefined(self) && isalive(self)) {
    thread function_93caad88720d8064("BEHAVIOR2");
  }
}

function function_29b3cd72300804be() {
  if(isDefined(self) && isalive(self)) {
    thread function_93caad88720d8064("BEHAVIOR4");
  }
}

function function_d9c2d13ae0f4fbcb() {
  self.var_50cf411802ee43ce = spawnStruct();
  self.var_50cf411802ee43ce.var_9c3f4df602c70997 = undefined;
  self.var_50cf411802ee43ce.var_d4d48422d1660504 = undefined;
  self.var_50cf411802ee43ce.var_5fa7de1d4e75d893 = 120000;
  self.var_50cf411802ee43ce.var_111072f2a4205196 = [];
  self.var_50cf411802ee43ce.var_3231bfdeb1f1382c = function_d7662087b637a517("AllForOne");
}

function function_ad4a51e0b0472ebd() {
  if(isDefined(self) && isalive(self)) {
    thread function_93caad88720d8064("BEHAVIOR1");
  }
}

function function_a15f7af910d7f1b6() {
  if(isDefined(self) && isalive(self)) {
    thread function_93caad88720d8064("BEHAVIOR2");
  }
}

function function_1bfced88fed9a20b() {
  if(isDefined(self) && isalive(self)) {
    thread function_93caad88720d8064("BEHAVIOR3");
  }
}

function function_42f4a9aee5b6c6d3() {
  if(isDefined(self) && isalive(self)) {
    thread function_93caad88720d8064("BEHAVIOR4", undefined, 1);
    function_186c5399d7bd519c();
  }
}

function function_404390b3c8b3e9d3() {
  if(isDefined(self) && isalive(self)) {
    thread function_93caad88720d8064("BEHAVIOR2");
  }
}

function function_80e71915de4ee2ca(player) {
  if(isDefined(self) && isalive(self)) {
    thread function_93caad88720d8064("BEHAVIOR3", player);
  }
}

function private function_bb1d5509c601171a() {
  if(!isDefined(self)) {
    return;
  }

  level notify("<dev string:x1f9>");
  level endon("<dev string:x1f9>");

  for(;;) {
    if(!getdvarint(@ "hash_48a3c38e3b8d5b4d", 0) || !isDefined(self) || !isDefined(self.var_50cf411802ee43ce)) {} else {
      offset_x = 400;
      offset_y = 100;
      scale = 1;
      line_y = 20;
      msg = "<dev string:x219>";
      default_color = (0, 1, 0);

      if(isDefined(self.var_50cf411802ee43ce.var_d4d48422d1660504)) {
        printtoscreen2d(offset_x, offset_y, "<dev string:x219>" + self.var_50cf411802ee43ce.var_d4d48422d1660504, (1, 0, 0), scale);
        offset_y += line_y;
        printtoscreen2d(offset_x, offset_y, "<dev string:x228>" + self.var_50cf411802ee43ce.activecategory, (1, 0, 0), scale);
        offset_y += line_y;
      } else {
        printtoscreen2d(offset_x, offset_y, "<dev string:x237>", default_color, scale);
        offset_y += line_y;
      }

      if(isDefined(self.var_50cf411802ee43ce.var_3231bfdeb1f1382c)) {
        foreach(category, aliases in self.var_50cf411802ee43ce.var_3231bfdeb1f1382c) {
          printtoscreen2d(offset_x, offset_y, "<dev string:x249>" + category, (1, 0, 0), scale);
          offset_y += line_y;

          foreach(alias in aliases) {
            printtoscreen2d(offset_x, offset_y, "<dev string:x257>" + alias, default_color, scale);
            offset_y += line_y;
          }
        }
      }

      draw_character_capsule(default_color, 0, 1);
      line(self.origin, self.origin + (0, 0, 500), default_color, 1, 0, 1);
    }

    waitframe();
  }
}

function private function_78ea414bb61b846c(text) {
  if(!getdvarint(@ "hash_48a3c38e3b8d5b4d", 0)) {
    return;
  }

  scripts\common\debug::function_7320cd1e4f724899(text);

  if(isDefined(self) && isDefined(self.agent_type)) {
    text += "<dev string:x25d>" + self.agent_type;
  }

  println(text);
}

# /