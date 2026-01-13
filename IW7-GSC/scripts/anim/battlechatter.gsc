/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\battlechatter.gsc
*********************************************/

func_9542() {
  if(isDefined(level.var_3D4B) && level.var_3D4B) {
    return;
  }

  setdvarifuninitialized("bcs_enable", 1);
  if(getdvarint("bcs_enable") == 0) {
    anim.var_3D4B = 0;
    level.player.var_3D4B = 0;
    return;
  }

  anim.var_29B7 = 0;
  anim.var_3D4B = 1;
  level.player.var_3D4B = 0;
  if(!isDefined(level.var_7410)) {
    level.var_7410 = 1;
  }

  setdvarifuninitialized("bcs_filterThreat", "off");
  setdvarifuninitialized("bcs_filterInform", "off");
  setdvarifuninitialized("bcs_filterOrder", "off");
  setdvarifuninitialized("bcs_filterReaction", "off");
  setdvarifuninitialized("bcs_filterResponse", "off");
  setdvarifuninitialized("bcs_forceEnglish", "0");
  setdvarifuninitialized("bcs_allowsamevoiceresponse", "off");
  setdvarifuninitialized("debug_bcprint", "off");
  setdvarifuninitialized("debug_bcprintdump", "off");
  setdvarifuninitialized("debug_bcprintdumptype", "csv");
  setdvarifuninitialized("debug_bcshowqueue", "off");
  anim.var_29B1 = "^3***** BCS FAILURE: ";
  anim.var_29B2 = "^3***** BCS WARNING: ";
  func_29C4();
  func_29C2();
  level.var_D3DD["unitednations"] = "1";
  level.var_D3DD["unitednationshelmet"] = "1";
  level.var_D3DD["unitednationsfemale"] = "1";
  level.var_D3DD["unitednationsjackal"] = "1";
  thread func_F7ED();
  func_95E5();
  anim.var_68BB = [];
  level.var_68BB["threat"] = [];
  level.var_68BB["response"] = [];
  level.var_68BB["reaction"] = [];
  level.var_68BB["order"] = [];
  level.var_68BB["inform"] = [];
  level.var_68BB["custom"] = [];
  level.var_68BB["direction"] = [];
  if(isDefined(level._stealth)) {
    level.var_68AD["threat"]["self"] = 20000;
    level.var_68AD["threat"]["squad"] = 30000;
  } else if(scripts\sp\utility::func_D123()) {
    level.var_68AD["threat"]["self"] = 11000;
    level.var_68AD["threat"]["squad"] = 7000;
  } else {
    level.var_68AD["threat"]["self"] = 9000;
    level.var_68AD["threat"]["squad"] = 5000;
  }

  level.var_68AD["threat"]["location_repeat"] = 15000;
  level.var_68AD["response"]["self"] = 1400;
  level.var_68AD["response"]["squad"] = 1400;
  level.var_68AD["reaction"]["self"] = 1400;
  level.var_68AD["reaction"]["squad"] = 1400;
  level.var_68AD["order"]["self"] = 7000;
  level.var_68AD["order"]["squad"] = 6000;
  level.var_68AD["inform"]["self"] = 4000;
  level.var_68AD["inform"]["squad"] = 6000;
  level.var_68AD["custom"]["self"] = 0;
  level.var_68AD["custom"]["squad"] = 0;
  level.var_68BB["playername"] = -15536;
  level.var_68BB["reaction"]["casualty"] = 14000;
  level.var_68BB["reaction"]["friendlyfire"] = 5000;
  level.var_68BB["reaction"]["takingfire"] = -30536;
  level.var_68BB["reaction"]["maneuver"] = 24000;
  level.var_68BB["reaction"]["movement"] = 24000;
  level.var_68BB["reaction"]["underfire"] = 24000;
  level.var_68BB["reaction"]["danger"] = 14000;
  level.var_68BB["reaction"]["ask_ok"] = 14000;
  level.var_68BB["reaction"]["taunt"] = 25000;
  level.var_68BB["inform"]["reloading"] = 30000;
  level.var_68BB["inform"]["killfirm"] = -25536;
  level.var_68BB["inform"]["attack"] = 9000;
  level.var_68BB["threat"]["acquired"] = 7000;
  level.var_68BB["threat"]["sighted"] = 7000;
  level.var_68BB["reaction"]["maneuver"] = 15000;
  level.var_68BB["reaction"]["underfire"] = 2000;
  level.var_68BB["order"]["action"] = 9000;
  level.var_68BB["response"]["callout"] = 7000;
  level.var_68B5["threat"]["infantry"] = 0.6;
  level.var_68B5["threat"]["vehicle"] = 0.7;
  level.var_68B5["threat"]["sighted"] = 0.6;
  level.var_68B5["threat"]["acquired"] = 0.6;
  level.var_68B5["threat"]["c12"] = 0.7;
  level.var_68B5["response"]["ack"] = 0.9;
  level.var_68B5["response"]["exposed"] = 0.8;
  level.var_68B5["response"]["callout"] = 0.9;
  level.var_68B5["response"]["echo"] = 0.9;
  level.var_68B5["response"]["covering"] = 0.9;
  level.var_68B5["response"]["im"] = 0.9;
  level.var_68B5["reaction"]["casualty"] = 0.5;
  level.var_68B5["reaction"]["friendlyfire"] = 1;
  level.var_68B5["reaction"]["takingfire"] = 1;
  level.var_68B5["reaction"]["maneuver"] = 0.8;
  level.var_68B5["reaction"]["movement"] = 0.8;
  level.var_68B5["reaction"]["underfire"] = 0.8;
  level.var_68B5["reaction"]["danger"] = 0.8;
  level.var_68B5["reaction"]["ask_ok"] = 1;
  level.var_68B5["reaction"]["taunt"] = 0.9;
  level.var_68B5["order"]["action"] = 0.3;
  level.var_68B5["order"]["move"] = 0.3;
  level.var_68B5["order"]["displace"] = 0.5;
  level.var_68B5["inform"]["attack"] = 0.9;
  level.var_68B5["inform"]["incoming"] = 0.9;
  level.var_68B5["inform"]["reloading"] = 0.2;
  level.var_68B5["inform"]["suppressed"] = 0.2;
  level.var_68B5["inform"]["killfirm"] = 0.4;
  level.var_68B5["custom"]["generic"] = 1;
  level.var_68AF["threat"]["infantry"] = 1000;
  level.var_68AF["threat"]["vehicle"] = 1000;
  level.var_68AF["threat"]["sighted"] = 1500;
  level.var_68AF["threat"]["acquired"] = 1500;
  level.var_68AF["threat"]["c12"] = 1000;
  level.var_68AF["response"]["exposed"] = 1000;
  level.var_68AF["response"]["callout"] = 2000;
  level.var_68AF["response"]["echo"] = 2000;
  level.var_68AF["response"]["ack"] = 1000;
  level.var_68AF["response"]["covering"] = 1500;
  level.var_68AF["response"]["im"] = 1500;
  level.var_68AF["reaction"]["casualty"] = 1000;
  level.var_68AF["reaction"]["friendlyfire"] = 1000;
  level.var_68AF["reaction"]["takingfire"] = 1500;
  level.var_68AF["reaction"]["maneuver"] = 1500;
  level.var_68AF["reaction"]["movement"] = 1500;
  level.var_68AF["reaction"]["underfire"] = 1500;
  level.var_68AF["reaction"]["danger"] = 1500;
  level.var_68AF["reaction"]["ask_ok"] = 1500;
  level.var_68AF["reaction"]["taunt"] = 2000;
  level.var_68AF["order"]["action"] = 3000;
  level.var_68AF["order"]["move"] = 3000;
  level.var_68AF["order"]["displace"] = 3000;
  level.var_68AF["inform"]["attack"] = 1000;
  level.var_68AF["inform"]["incoming"] = 1500;
  level.var_68AF["inform"]["reloading"] = 1000;
  level.var_68AF["inform"]["suppressed"] = 2000;
  level.var_68AF["inform"]["killfirm"] = 2000;
  level.var_68AF["custom"]["generic"] = 1000;
  level.var_68AE["response"]["exposed"] = 75;
  level.var_68AE["response"]["reload"] = 50;
  level.var_68AE["response"]["callout"] = 75;
  level.var_68AE["response"]["callout_negative"] = 20;
  level.var_68AE["response"]["order"] = 40;
  level.var_68AE["moveEvent"]["coverme"] = 70;
  level.var_68AE["moveEvent"]["ordertoplayer"] = 10;
  if(scripts\sp\utility::func_D123()) {
    anim.var_6BB2 = 9999999;
    anim.var_6BB8 = 2;
    anim.var_6BB7 = 5;
    anim.var_6BB6 = 0.5;
    anim.var_6BB5 = 3;
  } else {
    anim.var_6BB2 = 620;
    anim.var_6BB8 = 12;
    anim.var_6BB7 = 24;
    anim.var_6BB6 = 2;
    anim.var_6BB5 = 5;
  }

  anim.var_BCD1 = spawn("script_origin", (0, 0, 0));
  if(!isDefined(level.var_29BD)) {
    if(scripts\sp\utility::func_D123()) {
      level.var_29BD = squared(9999999);
    } else {
      level.var_29BD = squared(3000);
    }
  }

  if(!isDefined(level.var_29BE)) {
    if(scripts\sp\utility::func_D123()) {
      level.var_29BE = squared(9999999);
    } else {
      level.var_29BE = squared(5000);
    }
  }

  level.var_8D0F = 96;
  level.var_B75D = 10;
  level.maxdistancecallout = 45;
  level.var_B4A4 = 50;
  scripts\common\bcs_location_trigs::bcs_location_trigs_init();
  anim.var_EF74 = 4000;
  anim.var_29C6 = 3000;
  level.var_10AE0[level.var_10AE0.size] = ::func_9762;
  level.var_10AE1[level.var_10AE1.size] = "::init_squadBattleChatter";
  foreach(var_1 in level.var_115E7) {
    level.isteamspeaking[var_1] = 0;
    level.isteamsaying[var_1]["threat"] = 0;
    level.isteamsaying[var_1]["order"] = 0;
    level.isteamsaying[var_1]["reaction"] = 0;
    level.isteamsaying[var_1]["response"] = 0;
    level.isteamsaying[var_1]["inform"] = 0;
    level.isteamsaying[var_1]["custom"] = 0;
  }

  func_29C1();
  func_29C3();
  anim.var_AA27 = [];
  anim.var_A9C3 = [];
  anim.var_A9C4 = [];
  foreach(var_1 in level.var_115E7) {
    level.var_AA27[var_1] = --15536;
    level.var_A9C3[var_1] = "none";
    level.var_A9C4[var_1] = -100000;
  }

  anim.var_A9C5 = 120000;
  for(var_5 = 0; var_5 < level.var_10AE5.size; var_5++) {
    if(isDefined(level.var_10AE5[var_5].var_3D4B) && level.var_10AE5[var_5].var_3D4B) {
      continue;
    }

    level.var_10AE5[var_5] func_9762();
  }

  anim.var_117E0 = [];
  level.var_117E0["exposed"] = 25;
  level.var_117E0["sighted"] = 25;
  level.var_117E0["acquired"] = 50;
  level.var_117E0["player_distance"] = 20;
  level.var_117E0["player_obvious"] = 25;
  level.var_117E0["player_contact_clock"] = 25;
  level.var_117E0["player_target_clock"] = 25;
  level.var_117E0["player_target_clock_high"] = 25;
  level.var_117E0["player_cardinal"] = 20;
  level.var_117E0["ai_distance"] = 25;
  level.var_117E0["ai_obvious"] = 25;
  level.var_117E0["ai_contact_clock"] = 20;
  level.var_117E0["ai_casual_clock"] = 20;
  level.var_117E0["ai_target_clock"] = 20;
  level.var_117E0["ai_target_clock_high"] = 25;
  level.var_117E0["ai_cardinal"] = 10;
  level.var_117E0["concat_location"] = 90;
  level.var_117E0["player_location"] = 90;
  level.var_117E0["ai_location"] = 100;
  level.var_117E0["generic_location"] = 95;
  anim.var_AA28 = [];
  anim.var_AA29 = [];
  foreach(var_1 in level.var_115E7) {
    level.var_AA28[var_1] = undefined;
    level.var_AA29[var_1] = undefined;
  }

  if(scripts\sp\utility::func_D123()) {
    anim.var_115EE = 300000;
  } else {
    anim.var_115EE = 120000;
  }

  level notify("battlechatter initialized");
  anim notify("battlechatter initialized");
}

func_29C4() {
  if(!isDefined(level.var_115E7)) {
    anim.var_115E7 = [];
    level.var_115E7[level.var_115E7.size] = "axis";
    level.var_115E7[level.var_115E7.size] = "allies";
    level.var_115E7[level.var_115E7.size] = "team3";
    level.var_115E7[level.var_115E7.size] = "neutral";
  }
}

func_29C2() {
  if(!isDefined(level.var_13075)) {
    anim.var_13075 = [];
    anim.var_6EED = [];
    anim.var_46BD = [];
    func_29C5("unitednations", "UN", 6, 1);
    func_29C5("unitednationshelmet", "UN", 6, 1);
    func_29C5("unitednationsfemale", "UN", 3, 1);
    func_29C5("unitednationsjackal", "JK", 3, 1);
    func_29C5("setdef", "SD", 5);
    func_29C5("c6", "C6", 1);
  }
}

func_29C5(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  level.var_13075[var_0] = [];
  for(var_4 = 0; var_4 < var_2; var_4++) {
    level.var_13075[var_0][var_4] = spawnStruct();
    level.var_13075[var_0][var_4].var_C1 = 0;
    level.var_13075[var_0][var_4].npcid = "" + var_4;
  }

  level.var_46BD[var_0] = var_1;
  level.var_6EED[var_0] = var_3;
}

func_29C1() {
  func_29C4();
  if(!isDefined(level.var_28CF)) {
    level.var_28CF = [];
    foreach(var_1 in level.var_115E7) {
      scripts\sp\utility::func_F2DC(var_1, 0);
    }
  }
}

func_29C3() {
  func_29C4();
  if(!isDefined(level.var_6EE9)) {
    level.var_6EE9 = [];
    foreach(var_1 in level.var_115E7) {
      level.var_6EE9[var_1] = 0;
    }
  }
}

func_95E5() {
  level.var_6EE9["unitednations"] = [];
  var_0 = 41;
  for(var_1 = 0; var_1 < var_0; var_1++) {
    level.var_6EE9["unitednations"][var_1] = ::scripts\sp\utility::string(var_1 + 1);
  }

  level.var_6EE9["unitednationshelmet"] = [];
  var_0 = 41;
  for(var_1 = 0; var_1 < var_0; var_1++) {
    level.var_6EE9["unitednationshelmet"][var_1] = ::scripts\sp\utility::string(var_1 + 1);
  }

  level.var_6EE9["unitednationsfemale"] = [];
  var_0 = 41;
  for(var_1 = 0; var_1 < var_0; var_1++) {
    level.var_6EE9["unitednationsfemale"][var_1] = ::scripts\sp\utility::string(var_1 + 1);
  }

  level.var_6EE9["unitednationsjackal"] = [];
  var_0 = 13;
  for(var_1 = 0; var_1 < var_0; var_1++) {
    level.var_6EE9["unitednationsjackal"][var_1] = ::scripts\sp\utility::string(var_1 + 1);
  }

  anim.var_6EEC = [];
}

func_10179() {
  anim.var_46BD = undefined;
  anim.var_68BB = undefined;
  anim.var_68AD = undefined;
  anim.var_68BB = undefined;
  anim.var_68B5 = undefined;
  anim.var_68AF = undefined;
  anim.var_BCD1 = undefined;
  anim.var_EF74 = undefined;
  anim.var_29C6 = undefined;
  anim.locationlastcallouttimes = undefined;
  anim.var_13075 = undefined;
  anim.var_6EEC = undefined;
  anim.var_AA28 = undefined;
  anim.var_AA29 = undefined;
  anim.var_A9C5 = undefined;
  anim.var_A9C3 = undefined;
  anim.var_A9C4 = undefined;
  anim.var_3D4B = 0;
  level.player.var_3D4B = 0;
  level.var_28CF = undefined;
  anim.bcs_locations = undefined;
  for(var_0 = 0; var_0 < level.var_10AE0.size; var_0++) {
    if(level.var_10AE1[var_0] != "::init_squadBattleChatter") {
      continue;
    }

    if(var_0 != level.var_10AE0.size - 1) {
      level.var_10AE0[var_0] = level.var_10AE0[level.var_10AE0.size - 1];
      level.var_10AE1[var_0] = level.var_10AE1[level.var_10AE1.size - 1];
    }

    level.var_10AE0[level.var_10AE0.size - 1] = undefined;
    level.var_10AE1[level.var_10AE1.size - 1] = undefined;
  }

  level notify("battlechatter disabled");
  anim notify("battlechatter disabled");
}

func_9762() {
  var_0 = self;
  var_0.var_C242 = 0;
  var_0.var_B4C8 = 1;
  var_0.var_BFA8 = gettime() + 50;
  var_0.var_BFA9["threat"] = gettime() + 50;
  var_0.var_BFA9["order"] = gettime() + 50;
  var_0.var_BFA9["reaction"] = gettime() + 50;
  var_0.var_BFA9["response"] = gettime() + 50;
  var_0.var_BFA9["inform"] = gettime() + 50;
  var_0.var_BFA9["custom"] = gettime() + 50;
  var_0.var_BFB4["threat"] = [];
  var_0.var_BFB4["order"] = [];
  var_0.var_BFB4["reaction"] = [];
  var_0.var_BFB4["response"] = [];
  var_0.var_BFB4["inform"] = [];
  var_0.var_BFB4["custom"] = [];
  var_0.var_9E9B["threat"] = 0;
  var_0.var_9E9B["order"] = 0;
  var_0.var_9E9B["reaction"] = 0;
  var_0.var_9E9B["response"] = 0;
  var_0.var_9E9B["inform"] = 0;
  var_0.var_9E9B["custom"] = 0;
  var_0.var_A975 = "";
  var_0.var_B659[var_0.var_B659.size] = ::scripts\anim\battlechatter_ai::func_185D;
  var_0.var_B65F[var_0.var_B65F.size] = ::scripts\anim\battlechatter_ai::func_E11B;
  var_0.var_10AFD[var_0.var_10AFD.size] = ::func_97EE;
  var_0.var_6BB3 = 1;
  var_0.var_6BB4 = undefined;
  for(var_1 = 0; var_1 < level.var_10AE5.size; var_1++) {
    var_0 thread func_97EE(level.var_10AE5[var_1].var_10AEE);
  }

  var_0 thread scripts\anim\battlechatter_ai::func_10AFB();
  var_0 thread scripts\anim\battlechatter_ai::func_10AE7();
  var_0 thread func_10AE2();
  var_0.var_3D4B = 1;
  var_0 notify("squad chat initialized");
}

func_10182() {
  var_0 = self;
  var_0.var_C242 = undefined;
  var_0.var_B4C8 = undefined;
  var_0.var_BFA8 = undefined;
  var_0.var_BFA9 = undefined;
  var_0.var_BFB4 = undefined;
  var_0.var_9E9B = undefined;
  var_0.var_6BB3 = undefined;
  var_0.var_6BB4 = undefined;
  for(var_1 = 0; var_1 < var_0.var_B659.size; var_1++) {
    var_0.var_B659[var_1] = undefined;
  }

  for(var_1 = 0; var_1 < var_0.var_B65F.size; var_1++) {
    var_0.var_B660[var_1] = undefined;
  }

  for(var_1 = 0; var_1 < var_0.var_10AFD.size; var_1++) {
    var_0.var_10AFD[var_1] = undefined;
  }

  for(var_1 = 0; var_1 < level.var_10AE5.size; var_1++) {
    var_0 func_10183(level.var_10AE5[var_1].var_10AEE);
  }

  var_0.var_3D4B = 0;
}

func_29CA() {
  if(isDefined(level.var_3D4B)) {
    return level.var_3D4B;
  }

  return 0;
}

func_29C9() {
  var_0 = getdvarint("bcs_enable");
  for(;;) {
    var_1 = getdvarint("bcs_enable");
    if(var_1 != var_0) {
      switch (var_1) {
        case 1:
          if(!level.var_3D4B) {
            enablebattlechatter();
          }
          break;

        case 0:
          if(level.var_3D4B) {
            disablebattlechatter();
          }
          break;
      }

      var_0 = var_1;
    }

    wait(1);
  }
}

enablebattlechatter() {
  func_9542();
  level.player thread scripts\anim\battlechatter_ai::func_185D();
  var_0 = getaiarray();
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] scripts\anim\battlechatter_ai::func_185D();
  }
}

disablebattlechatter() {
  if(!isDefined(level.var_3D4B)) {
    return;
  }

  func_10179();
  var_0 = getaiarray();
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isDefined(var_0[var_1].var_10AC8) && var_0[var_1].var_10AC8.var_3D4B) {
      var_0[var_1].var_10AC8 func_10182();
    }

    var_0[var_1] scripts\anim\battlechatter_ai::func_E11B();
  }
}

func_F7ED(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    level.player.var_29AE = var_0;
    level.player.var_29A3 = var_1;
    return;
  }

  while(!isDefined(level.var_37E7)) {
    wait(0.1);
  }

  var_2 = level.var_37E7;
  var_3 = level.var_D3DD[var_2];
  var_4 = level.var_46BD[var_2];
  if(isDefined(var_3)) {
    level.player.var_29AE = var_3;
  }

  if(isDefined(var_4)) {
    level.player.var_29A3 = var_4;
  }
}

func_CEE8(var_0) {
  if(!isalive(self)) {
    return;
  }

  if(!isDefined(self.team)) {
    return;
  }

  if(!func_29CA()) {
    return;
  }

  if(isDefined(self.var_117C) && self.var_117C > 0) {
    return;
  }

  if(isDefined(self.var_9F6B) && self.var_9F6B) {
    return;
  }

  if(!isDefined(self.team) || isDefined(self.team) && self.team == "allies" && isDefined(level.var_EF75)) {
    if(level.var_EF75 + level.var_EF74 > gettime()) {
      return;
    }
  }

  if(func_740F()) {
    return;
  }

  if(!isDefined(self.var_28CF) || !self.var_28CF) {
    return;
  }

  if(!isDefined(self.team) || isDefined(self.team) && self.team == "allies" && getdvarint("bcs_forceEnglish", 0)) {
    return;
  }

  if(level.isteamspeaking[self.team]) {
    return;
  }

  self endon("death");
  if(!isDefined(var_0)) {
    var_0 = func_7EFE();
  }

  if(isDefined(self.var_299A)) {
    var_0 = self.var_299A;
  }

  if(!isDefined(var_0)) {
    return;
  }

  if(isDefined(self.melee)) {
    if(isDefined(self.melee.var_9904)) {
      if(self.melee.var_9904) {
        return;
      }
    }
  }

  if(self == level.player) {
    if(!isDefined(level.player.var_28CF) || isDefined(level.player.var_28CF) && !level.player.var_28CF) {
      return;
    }

    if(scripts\engine\utility::player_is_in_jackal()) {
      var_1 = level.player scripts\sp\utility::func_7B9D();
      if(var_1 < 0.3) {
        return;
      }
    }

    if(!isDefined(level.player.var_29C8) || level.player.var_29C8 != 0) {
      return;
    } else {
      level notify("player_battlechatter_refresh");
    }
  }

  switch (var_0) {
    case "custom":
      thread func_CF0A();
      break;

    case "response":
      thread func_D50A();
      break;

    case "order":
      thread func_D4EB();
      break;

    case "threat":
      thread func_D54B();
      break;

    case "reaction":
      thread func_D503();
      break;

    case "inform":
      thread func_D4A3();
      break;
  }
}

func_D54B() {
  self endon("death");
  self endon("removed from battleChatter");
  self endon("cancel speaking");
  self.var_4B1F = self.var_3D4C["threat"];
  var_0 = self.var_3D4C["threat"].var_117B9;
  if(!isalive(var_0)) {
    return;
  }

  if(func_117ED(var_0) && !isplayer(var_0)) {
    return;
  }

  anim thread func_AEEB(self, "threat");
  var_1 = 0;
  var_2 = self.var_3D4C["threat"].var_68BA;
  switch (var_2) {
    case "infantry":
      if((scripts\engine\utility::player_is_in_jackal() && var_0 == level.player) || !var_0 scripts\anim\battlechatter_ai::func_1A1B() && isplayer(var_0) || (!var_0 scripts\anim\battlechatter_ai::func_1A1B() && !isDefined(var_0 _meth_8164())) || var_0 scripts\anim\battlechatter_ai::func_1A1B()) {
        if(isDefined(self._blackboard)) {
          self._blackboard.var_28DE = var_0;
        }

        var_1 = func_117E4(var_0, undefined);
      }
      break;

    case "acquired":
    case "vehicle":
      self.var_3778 = var_2;
      var_1 = func_117E4(var_0, undefined);
      break;

    case "sighted":
      self.var_3778 = var_2;
      var_1 = func_117E4(var_0, undefined);
      break;
  }

  var_3 = self;
  var_3 notify("done speaking");
  if(!var_1) {
    return;
  }

  if(!isalive(var_0)) {
    return;
  }

  var_0.var_376A[var_3.var_10AC8.var_10AEE] = spawnStruct();
  var_0.var_376A[var_3.var_10AC8.var_10AEE].var_10A9F = var_3;
  var_0.var_376A[var_3.var_10AC8.var_10AEE].var_117EC = var_3.var_3D4C["threat"].var_68BA;
  var_0.var_376A[var_3.var_10AC8.var_10AEE].var_698B = gettime() + level.var_29C6;
  if(isDefined(var_0.var_10AC8)) {
    var_3.var_10AC8.var_10AE9[var_0.var_10AC8.var_10AEE].var_376A = 1;
  }
}

func_117ED(var_0) {
  if(isDefined(var_0.var_376A) && isDefined(var_0.var_376A[self.var_10AC8.var_10AEE])) {
    if(var_0.var_376A[self.var_10AC8.var_10AEE].var_698B > gettime()) {
      return 1;
    }
  }

  return 0;
}

func_117E4(var_0, var_1) {
  self endon("cancel speaking");
  var_2 = func_4996();
  var_2.var_B3D1 = 1;
  var_2.var_117E3 = var_0;
  var_3 = isdroppingweapon(var_0);
  if(!isDefined(var_3) || isDefined(var_3) && !isDefined(var_3.type)) {
    return 0;
  }

  var_4 = undefined;
  if(isDefined(self.var_3778)) {
    var_4 = self.var_3778;
  } else {
    var_4 = var_3.type;
  }

  switch (var_4) {
    case "exposed":
      if(isDefined(self._blackboard)) {
        self._blackboard.var_28DE = var_3.var_E29B;
      }

      var_5 = func_582F(var_3.var_E29B);
      var_6 = self;
      if(var_5 && var_6 cansayname(var_3.var_E29B)) {
        var_2 func_17F2(var_3.var_E29B.var_29AD);
        var_2.var_299D = var_3.var_E29B;
      }

      var_2 func_117E6(var_0);
      if(var_5) {
        if(randomint(100) < level.var_68AE["response"]["callout_negative"]) {
          var_3.var_E29B scripts\anim\battlechatter_ai::func_1820("callout", "neg", self, 0.9);
        } else {
          var_3.var_E29B scripts\anim\battlechatter_ai::func_1820("exposed", "acquired", self, 0.9);
        }
      }
      break;

    case "acquired":
      var_2 func_180F();
      var_2 func_1837("acquired", var_3.var_D371);
      break;

    case "sighted":
      var_2 func_180F();
      var_2 func_1837("sighted", var_3.var_D371);
      break;

    case "player_obvious":
      if(isDefined(self._blackboard)) {
        self._blackboard.var_28DE = level.player;
      }

      var_2 func_180F();
      var_2 func_1841();
      break;

    case "player_distance":
      if(isDefined(self._blackboard)) {
        self._blackboard.var_28DE = level.player;
      }

      if(scripts\engine\utility::player_is_in_jackal() && level.player == level.var_D127 && var_0 scripts\anim\battlechatter_ai::func_1A1B()) {
        var_7 = func_7E7D(level.var_D127.origin, var_0.origin);
      } else {
        var_7 = func_7E7B(level.player.origin, var_1.origin);
      }

      var_2 func_180F();
      var_2 func_183D(var_7);
      break;

    case "player_contact_clock":
      if(isDefined(self._blackboard)) {
        self._blackboard.var_28DE = var_0;
      }

      var_2 func_180F();
      var_2 func_1837("contactclock", var_3.var_D371);
      break;

    case "player_target_clock":
      if(isDefined(self._blackboard)) {
        self._blackboard.var_28DE = var_0;
      }

      var_2 func_180F();
      var_2 func_1837("targetclock", var_3.var_D371);
      break;

    case "player_target_clock_high":
      if(isDefined(self._blackboard)) {
        self._blackboard.var_28DE = var_0;
      }

      var_2 func_180F();
      var_8 = func_7E69(level.player.origin, var_0.origin);
      if(var_8 >= 20 && var_8 <= 50) {
        var_2 func_1837("targetclock", var_3.var_D371);
        var_2 func_183E(var_8);
      } else {
        return 0;
      }
      break;

    case "player_cardinal":
      if(isDefined(self._blackboard)) {
        self._blackboard.var_28DE = var_0;
      }

      var_2 func_180F();
      var_9 = func_7E74(level.player.origin, var_0.origin);
      var_0A = func_C098(var_9);
      if(var_0A == "impossible") {
        return 0;
      }

      var_2 func_1837("cardinal", var_0A);
      break;

    case "ai_obvious":
      if(isDefined(var_3.var_E29B) && cansayname(var_3.var_E29B)) {
        var_2 func_17F2(var_3.var_E29B.var_29AD);
        var_2.var_299D = var_3.var_E29B;
      }

      if(isDefined(self._blackboard)) {
        self._blackboard.var_28DE = var_0;
      }

      var_2 func_1841();
      var_2 func_17B2(self, var_3, var_0);
      break;

    case "ai_distance":
      var_0B = self;
      if(self.team == "allies") {
        var_0B = level.player;
      } else if(isDefined(var_3.var_E29B) && randomint(100) < level.var_68AE["response"]["callout"]) {
        var_0B = var_3.var_E29B;
      }

      if(var_0B scripts\anim\battlechatter_ai::func_1A1B() && var_0 scripts\anim\battlechatter_ai::func_1A1B()) {
        var_7 = func_7E7D(var_0B.origin, var_0.origin);
      } else if(scripts\engine\utility::player_is_in_jackal() && var_7 == level.var_D127 && var_1 scripts\anim\battlechatter_ai::func_1A1B()) {
        var_7 = func_7E7D(var_7.origin, var_1.origin);
      } else {
        var_7 = func_7E7B(var_7.origin, var_1.origin);
      }

      if(isDefined(self._blackboard)) {
        self._blackboard.var_28DE = var_0;
      }

      var_2 func_183D(var_7);
      var_2 func_17B2(self, var_3, var_0);
      break;

    case "ai_contact_clock":
      var_0B = self;
      if(self.team == "allies") {
        var_0B = level.player;
      } else if(isDefined(var_3.var_E29B) && randomint(100) < level.var_68AE["response"]["callout"]) {
        var_0B = var_3.var_E29B;
      }

      var_0C = getrelativeangles(var_0B);
      var_0D = func_7E75(var_0C, var_0B.origin, var_0.origin);
      var_2 func_1837("contactclock", var_0D);
      var_2 func_17B2(self, var_3, var_0);
      if(isDefined(self._blackboard)) {
        self._blackboard.var_28DE = var_0;
      }
      break;

    case "ai_casual_clock":
      var_0B = self;
      if(self.team == "allies") {
        var_0B = level.player;
      } else if(isDefined(var_3.var_E29B) && randomint(100) < level.var_68AE["response"]["callout"]) {
        var_0B = var_3.var_E29B;
      }

      var_0C = getrelativeangles(var_0B);
      var_0D = func_7E75(var_0C, var_0B.origin, var_0.origin);
      var_2 func_1837("casualclock", var_0D);
      var_2 func_17B2(self, var_3, var_0);
      if(isDefined(self._blackboard)) {
        self._blackboard.var_28DE = var_0;
      }
      break;

    case "ai_target_clock":
      var_0B = self;
      if(self.team == "allies") {
        var_0B = level.player;
      } else if(isDefined(var_3.var_E29B) && randomint(100) < level.var_68AE["response"]["callout"]) {
        var_0B = var_3.var_E29B;
      }

      var_0C = getrelativeangles(var_0B);
      var_0D = func_7E75(var_0C, var_0B.origin, var_0.origin);
      var_2 func_1837("targetclock", var_0D);
      var_2 func_17B2(self, var_3, var_0);
      if(isDefined(self._blackboard)) {
        self._blackboard.var_28DE = var_0;
      }
      break;

    case "ai_target_clock_high":
      var_0B = self;
      if(self.team == "allies") {
        var_0B = level.player;
      } else if(isDefined(var_3.var_E29B) && randomint(100) < level.var_68AE["response"]["callout"]) {
        var_0B = var_3.var_E29B;
      }

      var_0C = getrelativeangles(var_0B);
      var_0D = func_7E75(var_0C, var_0B.origin, var_0.origin);
      var_8 = func_7E69(var_0B.origin, var_0.origin);
      if(var_8 >= 20 && var_8 <= 50) {
        var_2 func_1837("targetclock", var_0D);
        var_2 func_183E(var_8);
      } else {
        return 0;
      }

      var_2 func_17B2(self, var_3, var_0);
      if(isDefined(self._blackboard)) {
        self._blackboard.var_28DE = var_0;
      }
      break;

    case "ai_cardinal":
      var_0B = self;
      if(self.team == "allies") {
        var_0B = level.player;
      }

      var_9 = func_7E74(var_0B.origin, var_0.origin);
      var_0A = func_C098(var_9);
      if(var_0A == "impossible") {
        return 0;
      }

      var_2 func_1837("cardinal", var_0A);
      if(isDefined(self._blackboard)) {
        self._blackboard.var_28DE = var_0;
      }
      break;

    case "generic_location":
      var_6 = self;
      if(isDefined(self._blackboard)) {
        self._blackboard.var_28DE = var_0;
      }

      var_0E = var_2 func_117E5(var_3, undefined, var_6);
      if(!var_0E) {
        return 0;
      }
      break;

    case "player_location":
      var_6 = self;
      var_2 func_180F();
      if(isDefined(self._blackboard)) {
        self._blackboard.var_28DE = level.player;
      }

      var_0E = var_2 func_117E5(var_3, undefined, var_6);
      if(!var_0E) {
        return 0;
      }
      break;

    case "concat_location":
      var_2 addconcattargetalias(var_0);
      var_6 = self;
      var_0B = self;
      if(self.team == "allies") {
        var_0B = level.player;
      }

      var_0E = var_2 func_117E5(var_3, 1, var_6);
      if(!var_0E) {
        return 0;
      }

      var_2 addconcatdirectionalias(var_0B, var_0);
      var_2 func_17B2(self, var_3, var_0);
      if(isDefined(self._blackboard)) {
        self._blackboard.var_28DE = var_0;
      }
      break;

    case "ai_location":
      var_6 = self;
      if(var_6 cansayname(var_3.var_E29B)) {
        var_2 func_17F2(var_3.var_E29B.var_29AD);
        var_2.var_299D = var_3.var_E29B;
      }

      var_0E = var_2 func_117E5(var_3, undefined, var_6);
      if(!var_0E) {
        return 0;
      }

      var_0F = var_2.var_10476.size - 1;
      var_10 = var_2.var_10476[var_0F];
      if(iscallouttypereport(var_10)) {
        var_3.var_E29B scripts\anim\battlechatter_ai::func_1820("callout", "echo", self, 0.9, var_10);
      } else if(iscallouttypeqa(var_10, self)) {
        var_3.var_E29B scripts\anim\battlechatter_ai::func_1820("callout", "QA", self, 0.9, var_10, var_3.location);
      } else if(randomint(100) < level.var_68AE["response"]["callout_negative"]) {
        var_3.var_E29B scripts\anim\battlechatter_ai::func_1820("callout", "neg", self, 0.9);
      } else {
        var_3.var_E29B scripts\anim\battlechatter_ai::func_1820("exposed", "acquired", self, 0.9);
      }

      if(isDefined(self._blackboard)) {
        self._blackboard.var_28DE = var_0;
      }
      break;
  }

  func_F77C(var_3.type);
  var_6 = self;
  if(isDefined(self._blackboard)) {
    self._blackboard.var_28D6 = 0;
  }

  var_6 func_D4F8(var_2, self);
  if(isDefined(self._blackboard)) {
    self._blackboard.var_28D0 = undefined;
    self._blackboard.var_28DE = undefined;
  }

  return 1;
}

func_582F(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(var_0.var_46BC != "UN") {
    return 0;
  }

  if(randomint(100) > level.var_68AE["response"]["exposed"]) {
    return 0;
  }

  return 1;
}

func_117E5(var_0, var_1, var_2) {
  var_3 = func_183A(var_0.location, var_1, var_2);
  return var_3;
}

func_17B2(var_0, var_1, var_2) {
  if(!isDefined(var_1.var_E29B)) {
    return;
  }

  if(var_1.var_E29B.team != var_0.team) {
    return;
  }

  if(randomint(100) > level.var_68AE["response"]["callout"]) {
    return;
  }

  var_3 = "affirm";
  if(!var_1.var_E29B scripts\anim\battlechatter_ai::func_29A2(var_2) && randomint(100) < level.var_68AE["response"]["callout_negative"]) {
    var_3 = "neg";
  }

  var_1.var_E29B scripts\anim\battlechatter_ai::func_1820("callout", var_3, var_0, 0.9);
}

isdroppingweapon(var_0) {
  var_1 = var_0 getvalidlocation(self);
  var_2 = func_7E75(self.angles, self.origin, var_0.origin);
  var_3 = finishplayerdamage(64, 1024, "response");
  var_4 = undefined;
  if(isDefined(var_3)) {
    var_4 = func_7E75(var_3.angles, var_3.origin, var_0.origin);
  }

  var_5 = func_7E75(level.player.angles, level.player.origin, var_0.origin);
  if(self.team == "allies") {
    var_6 = var_5;
    var_7 = level.player;
  } else if(isDefined(var_5)) {
    var_6 = var_6;
    var_7 = var_4;
  } else {
    var_6 = var_4;
    var_7 = self;
  }

  var_8 = func_7E7A(var_7.origin, var_0.origin);
  self.var_D6B2 = [];
  if(!isDefined(var_1) && var_0 isexposed(0)) {
    func_1812("exposed");
  }

  if(self.team == "allies") {
    var_9 = 0;
    if(var_0.origin[2] - var_7.origin[2] >= level.var_8D0F) {
      if(func_1812("player_target_clock_high")) {
        var_9 = 1;
      }
    }

    if(!var_9) {
      if(var_6 == "12") {
        func_1812("player_obvious");
        if(var_8 > level.var_B75D && var_8 < level.maxdistancecallout) {
          func_1812("player_distance");
        }
      }

      if(cansayplayername() && var_6 != "12") {
        func_1812("player_contact_clock");
        func_1812("player_target_clock");
        func_1812("player_cardinal");
      }
    }
  }

  var_9 = 0;
  if(var_0.origin[2] - var_7.origin[2] >= level.var_8D0F) {
    if(func_1812("ai_target_clock_high")) {
      var_9 = 1;
    }
  }

  func_1812("ai_casual_clock");
  if(!var_9) {
    if(var_6 == "12") {
      func_1812("ai_distance");
      if(var_8 > level.var_B75D && var_8 < level.maxdistancecallout) {
        func_1812("ai_obvious");
      }
    }

    func_1812("ai_contact_clock");
    func_1812("ai_target_clock");
    func_1812("ai_cardinal");
  }

  if(isDefined(var_1)) {
    if(canconcat(var_1)) {
      func_1812("concat_location");
    } else if(isDefined(var_1 getcannedresponse(self))) {
      if(isDefined(var_3)) {
        func_1812("ai_location");
      } else {
        if(cansayplayername()) {
          func_1812("player_location");
        }

        func_1812("generic_location");
      }
    } else {
      if(isDefined(var_3)) {
        func_1812("ai_location");
      }

      if(cansayplayername() || isDefined(self.var_C80C)) {
        func_1812("player_location");
      }

      func_1812("generic_location");
    }
  }

  if(!self.var_D6B2.size) {
    return undefined;
  }

  var_0B = getwholescenedurationmax(self.var_D6B2, level.var_117E0);
  var_0C = spawnStruct();
  var_0C.type = var_0B;
  var_0C.var_E29B = var_3;
  var_0C.var_E29C = var_4;
  var_0C.var_D371 = var_5;
  if(isDefined(var_1)) {
    var_0C.location = var_1;
  }

  return var_0C;
}

cancalloutlocation(var_0) {
  foreach(var_2 in var_0.locationaliases) {
    var_3 = getloccalloutalias("callout_loc_" + var_2);
    var_4 = getqacalloutalias(var_2, 0);
    var_5 = getloccalloutalias("concat_loc_" + var_2);
    var_6 = soundexists(var_3) || soundexists(var_4) || soundexists(var_5);
    if(var_6) {
      return var_6;
    }
  }

  return 0;
}

canconcat(var_0) {
  var_1 = var_0.locationaliases;
  foreach(var_3 in var_1) {
    if(iscallouttypeconcat(var_3, self)) {
      return 1;
    }
  }

  return 0;
}

getcannedresponse(var_0) {
  var_1 = undefined;
  var_2 = self.locationaliases;
  foreach(var_4 in var_2) {
    if(iscallouttypeqa(var_4, var_0) && !isDefined(self.qafinished)) {
      var_1 = var_4;
      break;
    }

    if(iscallouttypereport(var_4)) {
      var_1 = var_4;
    }
  }

  return var_1;
}

iscallouttypereport(var_0) {
  return issubstr(var_0, "_report");
}

iscallouttypeconcat(var_0, var_1) {
  var_2 = var_1 getloccalloutalias("concat_loc_" + var_0);
  if(soundexists(var_2)) {
    return 1;
  }

  return 0;
}

iscallouttypeqa(var_0, var_1) {
  if(issubstr(var_0, "_qa") && soundexists(var_0)) {
    return 1;
  }

  var_2 = var_1 getqacalloutalias(var_0, 0);
  if(soundexists(var_2)) {
    return 1;
  }

  return 0;
}

getloccalloutalias(var_0) {
  var_1 = undefined;
  if(self == level.player) {
    var_1 = "UN_plr_";
    var_1 = var_1 + var_0;
  } else {
    var_1 = self.var_46BC + "_" + self.npcid + "_";
    var_1 = var_1 + var_0;
  }

  return var_1;
}

getqacalloutalias(var_0, var_1) {
  var_2 = getloccalloutalias("callout_loc_" + var_0);
  var_2 = var_2 + "_qa" + var_1;
  return var_2;
}

func_17A2(var_0) {
  self.var_1C8B[self.var_1C8B.size] = var_0;
}

func_1812(var_0) {
  var_1 = 0;
  if(isDefined(self.var_1C8B)) {
    foreach(var_3 in self.var_1C8B) {
      if(var_3 == var_0) {
        if(!func_3783(var_0)) {
          var_1 = 1;
        }

        break;
      }
    }
  }

  if(!var_1) {
    return var_1;
  }

  self.var_D6B2[self.var_D6B2.size] = var_0;
  return var_1;
}

func_3783(var_0) {
  if(!isDefined(level.var_AA28[self.team])) {
    return 0;
  }

  if(!isDefined(level.var_AA29[self.team])) {
    return 0;
  }

  var_1 = level.var_AA28[self.team];
  var_2 = level.var_AA29[self.team];
  var_3 = level.var_115EE;
  if(isDefined(self.unittype) && self.unittype != "c6") {
    if(var_0 == var_1 && gettime() - var_2 < var_3) {
      return 1;
    }
  } else {
    return 0;
  }

  return 0;
}

func_F77C(var_0) {
  level.var_AA28[self.team] = var_0;
  level.var_AA29[self.team] = gettime();
}

getwholescenedurationmax(var_0, var_1) {
  var_2 = undefined;
  var_3 = -1;
  foreach(var_5 in var_0) {
    if(var_1[var_5] <= 0) {
      continue;
    }

    var_6 = randomint(var_1[var_5]);
    if(isDefined(var_2) && var_1[var_2] >= 100) {
      if(var_1[var_5] < 100) {
        continue;
      }

      continue;
    }

    if(var_1[var_5] >= 100) {
      var_2 = var_5;
      var_3 = var_6;
      continue;
    }

    if(var_6 > var_3) {
      var_2 = var_5;
      var_3 = var_6;
    }
  }

  return var_2;
}

func_117E6(var_0) {
  var_1 = [];
  var_1 = scripts\engine\utility::array_add(var_1, "open");
  var_1 = scripts\engine\utility::array_add(var_1, "breaking");
  var_1 = scripts\engine\utility::array_add(var_1, "generic");
  if(self.triggerportableradarping.team == "allies") {
    var_1 = scripts\engine\utility::array_add(var_1, "movement");
    var_2 = getaicount("axis");
    if(var_2 > 2) {
      var_1 = scripts\engine\utility::array_add(var_1, "group");
    }
  }

  var_3 = var_1[randomint(var_1.size)];
  func_1840(var_3);
}

func_D503() {
  self endon("death");
  self endon("removed from battleChatter");
  self.var_4B1F = self.var_3D4C["reaction"];
  var_0 = self.var_3D4C["reaction"].var_DD60;
  var_1 = self.var_3D4C["reaction"].modifiedspawnpoints;
  anim thread func_AEEB(self, "reaction");
  if(isDefined(self._blackboard)) {
    self._blackboard.var_28D0 = undefined;
  }

  var_2 = self.var_3D4C["reaction"].var_68BA;
  switch (var_2) {
    case "danger":
    case "underfire":
    case "movement":
    case "maneuver":
      func_DD50(var_0, var_1, var_2);
      break;

    case "casualty":
      func_DD4E(var_0, var_1, var_2);
      break;

    case "taunt":
      func_DD53(var_0, var_1, var_2);
      break;

    case "friendlyfire":
      func_DD4F(var_0, var_1, var_2);
      break;

    case "takingfire":
      func_DD52(var_0, var_1, var_2);
      if(scripts\engine\utility::cointoss()) {
        var_3 = finishplayerdamage(64, 1024, "response");
        if(isDefined(var_3)) {
          if(scripts\engine\utility::cointoss()) {
            if(var_3 cansay("reaction", "ask_ok", 1, undefined)) {
              var_3 scripts\anim\battlechatter_ai::func_181C("ask_ok", undefined, self, 1);
            }
          } else {
            var_3 scripts\anim\battlechatter_ai::func_1820("covering", "fire", self, 1);
          }
        }
      }
      break;

    case "ask_ok":
      func_E2A4(var_0, "ask", "ok");
      var_3 = finishplayerdamage(64, 1024, "response");
      if(isDefined(var_3)) {
        var_3 scripts\anim\battlechatter_ai::func_1820("im", "ok", self, 1);
      }
      break;
  }

  if(isDefined(self._blackboard)) {
    self._blackboard.var_28D0 = undefined;
  }

  self notify("done speaking");
}

func_DD50(var_0, var_1, var_2) {
  var_3 = self;
  var_3 endon("death");
  var_3 endon("removed from battleChatter");
  if(!isDefined(var_1) && !scripts\sp\utility::func_D123()) {
    var_1 = "generic";
  }

  var_4 = var_3 func_4996();
  var_4 func_181B(var_2, var_1);
  var_3 func_D4F8(var_4, self);
  wait(randomfloatrange(0.25, 0.5));
  if(scripts\engine\utility::cointoss()) {
    var_5 = var_3 finishplayerdamage(64, 100000, "order");
    if(isDefined(var_5)) {
      if(var_5 cansay("order", "action", 0.9)) {
        var_6 = scripts\engine\utility::random(["dive", "pullup", "break_generic", "break_right", "break_left"]);
        var_5 scripts\anim\battlechatter_ai::func_1809("action", var_6, var_3, 0.9);
        return;
      }
    }
  }
}

func_DD4E(var_0, var_1, var_2) {
  var_3 = self;
  var_3 endon("death");
  var_3 endon("removed from battleChatter");
  var_4 = var_3 func_4996();
  var_4 func_181B("casualty", "generic");
  var_3 func_D4F8(var_4, self);
}

func_DD53(var_0, var_1, var_2) {
  var_3 = self;
  self endon("death");
  self endon("removed from battleChatter");
  var_4 = var_3 func_4996();
  if(isDefined(var_1) && var_1 == "hostileburst") {
    var_4 func_17CF();
  } else {
    var_4 func_1834("taunt", "generic");
  }

  var_3 func_D4F8(var_4, self);
}

func_DD4F(var_0, var_1, var_2) {
  var_3 = self;
  var_3 endon("death");
  var_3 endon("removed from battleChatter");
  var_4 = var_3 func_4996();
  var_4 func_17BB();
  var_3 func_D4F8(var_4, self);
}

func_DD52(var_0, var_1, var_2) {
  var_3 = self;
  var_3 endon("death");
  var_3 endon("removed from battleChatter");
  var_4 = var_3 func_4996();
  var_4 func_1832();
  var_3 func_D4F8(var_4, self);
}

func_E2A4(var_0, var_1, var_2) {
  var_3 = self;
  var_3 endon("death");
  var_3 endon("removed from battleChatter");
  var_4 = var_3 func_4996();
  var_4 func_181F(var_1, var_2);
  var_3 func_D4F8(var_4, self);
}

func_D50A() {
  self endon("death");
  self endon("removed from battleChatter");
  self.var_4B1F = self.var_3D4C["response"];
  var_0 = self.var_3D4C["response"].modifiedspawnpoints;
  var_1 = self.var_3D4C["response"].var_E29D;
  if(!isalive(var_1) || func_9B42(var_1)) {
    return;
  }

  if(self.var_3D4C["response"].modifiedspawnpoints == "follow" && self.a.state != "move") {
    return;
  }

  anim thread func_AEEB(self, "response");
  switch (self.var_3D4C["response"].var_68BA) {
    case "exposed":
      func_E2A6(var_1, var_0);
      break;

    case "callout":
      func_E2A5(var_1, var_0, self.isnodeoccupied);
      break;

    case "ack":
      func_E2A2(var_1, var_0);
      break;

    default:
      func_E2A2(var_1, var_0);
      break;
  }

  self notify("done speaking");
}

func_E2A6(var_0, var_1) {
  var_2 = self;
  var_2 endon("death");
  var_2 endon("removed from battleChatter");
  if(!isalive(var_0)) {
    return;
  }

  var_3 = var_2 func_4996();
  var_3 func_1840(var_1);
  var_3.var_299D = var_0;
  var_3.var_B3D1 = 1;
  var_2 func_D4F8(var_3, self);
}

func_E2A5(var_0, var_1, var_2) {
  var_3 = self.var_4B1F.var_E1A1;
  var_4 = self.var_4B1F.location;
  var_5 = self;
  self endon("death");
  self endon("removed from battleChatter");
  if(!isalive(var_0)) {
    return;
  }

  var_6 = var_5 func_4996();
  var_7 = 0;
  if(var_1 == "echo") {
    var_7 = var_6 func_1838(var_3, var_0);
  } else if(var_1 == "QA") {
    var_7 = var_6 func_183B(var_0, var_3, var_4);
  } else {
    var_7 = var_6 func_183C(var_1, var_2);
  }

  if(!var_7) {
    return;
  }

  var_6.var_299D = var_0;
  var_6.var_B3D1 = 1;
  var_5 func_D4F8(var_6, self);
}

func_E2A2(var_0, var_1) {
  self endon("death");
  self endon("removed from battleChatter");
  if(!isalive(var_0)) {
    return;
  }

  var_2 = self.var_3D4C["response"].var_68BA;
  var_3 = self;
  var_4 = var_3 func_4996();
  var_4 func_181F(var_2, var_1);
  var_4.var_299D = var_0;
  var_4.var_B3D1 = 1;
  var_3 func_D4F8(var_4, self);
}

func_D4EB() {
  self endon("death");
  self endon("removed from battleChatter");
  self.var_4B1F = self.var_3D4C["order"];
  var_0 = self.var_3D4C["order"].modifiedspawnpoints;
  var_1 = self.var_3D4C["order"].var_C6E5;
  anim thread func_AEEB(self, "order");
  switch (self.var_3D4C["order"].var_68BA) {
    case "action":
      if(isDefined(self._blackboard)) {
        self._blackboard.var_28DE = level.player;
      }

      func_C6E1(var_0, var_1);
      break;

    case "move":
      func_C6E3(var_0, var_1);
      break;

    case "displace":
      func_C6E2(var_0);
      break;
  }

  if(isDefined(self._blackboard)) {
    self._blackboard.var_28D0 = undefined;
    self._blackboard.var_28DE = undefined;
  }

  self notify("done speaking");
}

func_C6E1(var_0, var_1) {
  var_2 = self;
  var_2 endon("death");
  var_2 endon("removed from battleChatter");
  var_3 = var_2 func_4996();
  if(!scripts\sp\utility::func_D123()) {
    var_2 func_128A8(var_3, var_1);
  }

  var_3 func_1808("action", var_0);
  var_2 func_D4F8(var_3, self);
}

func_C6E3(var_0, var_1) {
  var_2 = self;
  var_2 endon("death");
  var_2 endon("removed from battleChatter");
  var_3 = var_2 func_4996();
  var_2 func_128A8(var_3, var_1);
  var_3 func_1808("move", var_0);
  var_2 func_D4F8(var_3, self);
}

func_C6E2(var_0) {
  self endon("death");
  self endon("removed from battleChatter");
  var_1 = self;
  var_2 = var_1 func_4996();
  var_2 func_1808("displace", var_0);
  var_1 func_D4F8(var_2, self, 1);
}

func_128A8(var_0, var_1) {
  if(randomint(100) > level.var_68AE["response"]["order"]) {
    if(!isDefined(var_1) || isDefined(var_1) && !isplayer(var_1)) {
      return;
    }
  }

  if(isDefined(var_1) && isplayer(var_1) && isDefined(level.player.var_29AE)) {
    var_0 func_180F();
    var_0.var_299D = level.player;
    return;
  }

  if(isDefined(var_1) && cansayname(var_1)) {
    var_0 func_17F2(var_1.var_29AD);
    var_0.var_299D = var_1;
    var_1 scripts\anim\battlechatter_ai::func_1820("ack", "yes", self, 0.9);
    return;
  }

  level notify("follow order", self);
}

func_D4A3() {
  self endon("death");
  self endon("removed from battleChatter");
  self.var_4B1F = self.var_3D4C["inform"];
  var_0 = self.var_3D4C["inform"].modifiedspawnpoints;
  anim thread func_AEEB(self, "inform");
  if(self != level.player) {
    self._blackboard.var_28DE = level.player;
  }

  switch (self.var_3D4C["inform"].var_68BA) {
    case "incoming":
      func_94BE(var_0);
      break;

    case "attack":
      func_94BD(var_0);
      break;

    case "reloading":
      func_94C0(var_0);
      break;

    case "suppressed":
      func_94C1(var_0);
      break;

    case "killfirm":
      func_94BF(var_0);
      break;
  }

  self notify("done speaking");
}

func_94C0(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 endon("removed from battleChatter");
  var_2 = var_1 func_4996();
  var_2 func_17D1("reloading", var_0);
  var_1 func_D4F8(var_2, self);
}

func_94C1(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 endon("removed from battleChatter");
  var_2 = var_1 func_4996();
  var_2 func_17D1("suppressed", var_0);
  var_1 func_D4F8(var_2, self);
}

func_94BE(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 endon("removed from battleChatter");
  var_2 = var_1 func_4996();
  if(var_0 == "frag" || var_0 == "shock" || var_0 == "ant" || var_0 == "seek") {
    var_2.var_B3D1 = 1;
  }

  var_2 func_17D1("incoming", var_0);
  var_1 func_D4F8(var_2, self);
}

func_94BD(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 endon("removed from battleChatter");
  var_2 = var_1 func_4996();
  var_2 func_17D1("attack", var_0);
  var_1 func_D4F8(var_2, self);
}

func_94BF(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 endon("removed from battleChatter");
  var_2 = var_1 func_4996();
  var_2 func_17D1("killfirm", var_0, self.var_4B1F.var_117DE);
  var_1 func_D4F8(var_2, self);
}

func_CF0A() {
  var_0 = self.var_3D4C["custom"];
  self.var_4B1F = self.var_3D4C["custom"];
  var_1 = self;
  var_1 endon("death");
  var_1 endon("removed from battleChatter");
  anim thread func_AEEB(var_1, var_0.type, 1);
  var_1 func_D4F8(var_1.var_4C84, self);
  var_1 notify("done speaking");
  var_1.var_4C83 = undefined;
  var_1.var_4C84 = undefined;
}

func_D4F8(var_0, var_1, var_2) {
  anim endon("battlechatter disabled");
  self endon("dog_attacks_ai");
  self endon("death");
  if(isDefined(var_2)) {
    return;
  }

  if(scripts\anim\battlechatter_ai::func_1A1B() && !scripts\engine\utility::player_is_in_jackal()) {
    self notify("playPhrase_done");
    var_1 func_5ACA(var_1.var_4B1F.var_68AC, var_1.var_4B1F.var_68BA);
    return;
  }

  if(battlechatter_canprint() || battlechatter_canprintdump()) {
    var_3 = [];
    foreach(var_5 in var_0.var_10476) {
      var_3[var_3.size] = var_5;
    }

    if(battlechatter_canprint()) {
      battlechatter_print(var_3);
    }

    if(battlechatter_canprintdump()) {
      var_7 = self.var_4B1F.var_68AC + "_" + self.var_4B1F.var_68BA;
      if(isDefined(self.var_4B1F.modifiedspawnpoints)) {
        var_7 = var_7 + "_" + self.var_4B1F.modifiedspawnpoints;
      }

      thread battlechatter_printdump(var_3, var_7);
    }
  }

  for(var_8 = 0; var_8 < var_0.var_10476.size; var_8++) {
    if(!self.var_28CF) {
      if(!func_9BEB(self.var_4B1F)) {} else if(!func_3844(0)) {} else if((!isDefined(self.var_117C) && self != level.player && !scripts\anim\battlechatter_ai::func_1A1B()) || isDefined(self.var_117C) && self.var_117C > 0) {} else if(func_9DF3(var_1.var_4B1F.var_68AC)) {
        wait(0.85);
      } else if(!soundexists(var_0.var_10476[var_8])) {} else {
        var_9 = gettime();
        if(self == level.player) {
          var_0A = spawn("script_origin", level.player getEye());
          var_0A linkto(self);
        } else if(scripts\engine\utility::player_is_in_jackal()) {
          var_0B = level.player gettagorigin("tag_cockpit_light_monitor2");
          var_0A = spawn("script_origin", var_0B);
          var_0A linkto(level.player);
        } else {
          var_0A = spawn("script_origin", self gettagorigin("j_head"));
          var_0A linkto(var_1);
        }

        thread func_11047(var_0.var_10476[var_8], var_0A);
        func_F2DB(var_0.var_10476[var_8]);
        if(var_0.var_B3D1 && self.team == "allies") {
          thread scripts\sp\anim::func_1EBF(var_0.var_10476[var_8], var_0.var_299D);
          if(isDefined(self.classname) && self.classname == "player") {
            var_0C = self.health / self.maxhealth;
            if(var_0C > self.gs.healthoverlaycutoff) {
              var_0A playSound(var_0.var_10476[var_8], var_0.var_10476[var_8], 1);
            }
          } else {
            var_0A playSound(var_0.var_10476[var_8], var_0.var_10476[var_8], 1);
          }

          var_0A waittill(var_0.var_10476[var_8]);
          self notify(var_0.var_10476[var_8]);
        } else {
          thread scripts\sp\anim::func_1EBF(var_0.var_10476[var_8], var_0.var_299D);
          if(getdvarint("bcs_forceEnglish", 0)) {
            if(isDefined(self.classname) && self.classname == "player") {
              var_0C = self.health / self.maxhealth;
              if(var_0C > self.gs.healthoverlaycutoff) {
                var_0A playSound(var_0.var_10476[var_8], var_0.var_10476[var_8], 1);
              }
            } else {
              var_0A playSound(var_0.var_10476[var_8], var_0.var_10476[var_8], 1);
            }
          } else if(isDefined(self.classname) && self.classname == "player") {
            var_0C = self.health / self.maxhealth;
            if(var_0C > self.gs.healthoverlaycutoff) {
              var_0A playSound(var_0.var_10476[var_8], var_0.var_10476[var_8], 1);
            }
          } else {
            var_0A playSound(var_0.var_10476[var_8], var_0.var_10476[var_8], 1);
          }

          var_0A waittill(var_0.var_10476[var_8]);
          self notify(var_0.var_10476[var_8]);
        }

        var_0A delete();
        if(gettime() < var_9 + 250) {}
      }
    }
  }

  self notify("playPhrase_done");
  if(self != level.player) {
    self._blackboard.var_28DE = undefined;
    self._blackboard.var_28D0 = undefined;
  }

  var_1 func_5ACA(var_1.var_4B1F.var_68AC, var_1.var_4B1F.var_68BA);
}

func_F2DB(var_0) {
  var_1 = strtok(var_0, "_");
  if(!isDefined(self._blackboard)) {
    return;
  }

  if(scripts\engine\utility::array_contains(var_1, "killfirm")) {
    self._blackboard.var_28D0 = "action";
    return;
  }

  if(scripts\engine\utility::array_contains(var_1, "action")) {
    self._blackboard.var_28D0 = "action";
    return;
  }

  if(scripts\engine\utility::array_contains(var_1, "attack") && !scripts\engine\utility::array_contains(var_1, "grenade")) {
    self._blackboard.var_28D0 = "attacking_action";
    return;
  }

  if(scripts\engine\utility::array_contains(var_1, "grenade") || scripts\engine\utility::array_contains(var_1, "incoming") || scripts\engine\utility::array_contains(var_1, "inform") && !scripts\engine\utility::array_contains(var_1, "taking")) {
    self._blackboard.var_28D0 = "defending_action";
    return;
  }

  if(scripts\engine\utility::array_contains(var_1, "order")) {
    self._blackboard.var_28D0 = "order_action";
    return;
  }

  if(scripts\engine\utility::array_contains(var_1, "callout") || scripts\engine\utility::array_contains(var_1, "dist") || scripts\engine\utility::array_contains(var_1, "exposed") && !scripts\engine\utility::array_contains(var_1, "acquired")) {
    self._blackboard.var_28D0 = "threat_infantry";
    return;
  }

  if(scripts\engine\utility::array_contains(var_1, "taking")) {
    self._blackboard.var_28D0 = "takingfire";
    return;
  }

  if(scripts\engine\utility::array_contains(var_1, "resp") || scripts\engine\utility::array_contains(var_1, "affirm") || scripts\engine\utility::array_contains(var_1, "acquired")) {
    self._blackboard.var_28D0 = "response";
    return;
  }
}

func_11047(var_0, var_1) {
  var_1 endon("death");
  self waittill("death");
  if(isDefined(var_1)) {
    var_1 stopsounds();
    scripts\engine\utility::waitframe();
    if(isDefined(var_1)) {
      var_1 notify(var_0);
      var_1 delete();
    }
  }
}

func_9BEB(var_0) {
  if(!isDefined(var_0.var_68AC) || !isDefined(var_0.var_68BA)) {
    return 0;
  }

  if(var_0.var_68AC == "reaction" && var_0.var_68BA == "friendlyfire") {
    return 1;
  }

  return 0;
}

func_9F6C(var_0) {
  self endon("death");
  self endon("removed from battleChatter");
  wait(25);
  func_41BC(var_0);
}

func_41BC(var_0) {
  self.var_9F6B = 0;
  self.var_3D4C[var_0].var_698B = 0;
  self.var_3D4C[var_0].priority = 0;
  if(isDefined(self.unittype) && self.unittype != "c6") {
    self.var_BFA9[var_0] = gettime() + level.var_68AD[var_0]["self"];
    return;
  }

  self.var_BFA9[var_0] = gettime() + 1;
}

func_AEEB(var_0, var_1, var_2) {
  anim endon("battlechatter disabled");
  var_3 = var_0.var_10AC8;
  var_4 = var_0.team;
  var_0.var_9F6B = 1;
  var_0 thread func_9F6C(var_1);
  var_3.var_9E9B[var_1] = 1;
  var_3.var_C242++;
  level.isteamspeaking[var_4] = 1;
  level.isteamsaying[var_4][var_1] = 1;
  var_5 = var_0 scripts\engine\utility::waittill_any_return("death", "done speaking", "cancel speaking");
  var_3.var_9E9B[var_1] = 0;
  var_3.var_C242--;
  level.isteamspeaking[var_4] = 0;
  level.isteamsaying[var_4][var_1] = 0;
  if(var_5 == "cancel speaking") {
    return;
  }

  level.var_AA27[var_4] = gettime();
  if(isalive(var_0)) {
    var_0 func_41BC(var_1);
  }

  var_3.var_BFA9[var_1] = gettime() + level.var_68AD[var_1]["squad"];
}

func_12E7C(var_0, var_1) {
  if(gettime() - self.var_10AE9[var_0].var_A95F > 10000) {
    var_2 = 0;
    for(var_3 = 0; var_3 < self.var_B661.size; var_3++) {
      if(self.var_B661[var_3] != var_1 && isalive(self.var_B661[var_3].isnodeoccupied) && isDefined(self.var_B661[var_3].isnodeoccupied.var_10AC8) && self.var_B661[var_3].isnodeoccupied.var_10AC8.var_10AEE == var_0) {
        var_2 = 1;
      }
    }

    if(!var_2) {
      self.var_10AE9[var_0].firstcontact = gettime();
      self.var_10AE9[var_0].var_376A = 0;
    }
  }

  self.var_10AE9[var_0].var_A95F = gettime();
}

cansay(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("removed from battleChatter");
  if(isDefined(self.unittype) && self.unittype == "c8") {
    return 0;
  }

  if(isDefined(self.unittype) && self.unittype == "c12") {
    return 0;
  }

  if(!isDefined(level.player.var_28CF) || isDefined(level.player.var_28CF) && !level.player.var_28CF && isplayer(self)) {
    return 0;
  }

  if(distance(level.player.origin, self.origin) > level.var_29BD) {
    return 0;
  }

  if(!isDefined(self.var_28CF) || !self.var_28CF || !isDefined(self.var_BFA9)) {
    return 0;
  }

  if(isDefined(var_2) && var_2 >= 1) {
    return 1;
  }

  if(gettime() + level.var_68AD[var_0]["self"] < self.var_BFA9[var_0]) {
    return 0;
  }

  if(gettime() + level.var_68AD[var_0]["squad"] < self.var_10AC8.var_BFA9[var_0]) {
    return 0;
  }

  if(isDefined(var_1) && func_12AE7(var_0, var_1)) {
    return 0;
  }

  if(isDefined(var_1) && level.var_68B5[var_0][var_1] < self.var_29BF) {
    return 0;
  }

  return 1;
}

func_7EFE() {
  var_0 = undefined;
  var_1 = -999999999;
  foreach(var_4, var_3 in self.var_3D4C) {
    if(func_9FD7(var_4)) {
      if(var_3.priority > var_1) {
        var_0 = var_4;
        var_1 = var_3.priority;
      }
    }
  }

  return var_0;
}

_meth_83DE(var_0) {
  if(!level.isteamsaying[level.var_115E7[0]][var_0] && !level.isteamsaying[level.var_115E7[1]][var_0] && !level.isteamsaying[level.var_115E7[2]][var_0] && !level.isteamsaying[level.var_115E7[3]][var_0]) {
    return 1;
  }

  return 0;
}

_meth_819F(var_0) {
  var_1 = self.var_10AC8;
  var_2 = [];
  for(var_3 = 0; var_3 < var_1.var_B661.size; var_3++) {
    if(isDefined(var_1.var_B661[var_3].isnodeoccupied) && var_1.var_B661[var_3].isnodeoccupied == var_0) {
      var_2[var_2.size] = var_1.var_B661[var_3];
    }
  }

  if(!isDefined(var_2[0])) {
    return undefined;
  }

  var_4 = undefined;
  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(var_2[var_3] cansay("response")) {
      return var_4;
    }
  }

  return scripts\engine\utility::getclosest(self.origin, var_2);
}

disableplayeruse() {
  var_0 = [];
  var_1 = [];
  var_0[0] = "custom";
  var_0[1] = "response";
  var_0[2] = "order";
  var_0[3] = "threat";
  var_0[4] = "inform";
  for(var_2 = var_0.size - 1; var_2 >= 0; var_2--) {
    for(var_3 = 1; var_3 <= var_2; var_3++) {
      if(self.var_3D4C[var_0[var_3 - 1]].priority < self.var_3D4C[var_0[var_3]].priority) {
        var_4 = var_0[var_3 - 1];
        var_0[var_3 - 1] = var_0[var_3];
        var_0[var_3] = var_4;
      }
    }
  }

  var_5 = 0;
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_6 = func_7EA1(var_0[var_2]);
    if(var_6 == " valid" && !var_5) {
      var_5 = 1;
      var_1[var_2] = "g " + var_0[var_2] + var_6 + " " + self.var_3D4C[var_0[var_2]].priority;
      continue;
    }

    if(var_6 == " valid") {
      var_1[var_2] = "y " + var_0[var_2] + var_6 + " " + self.var_3D4C[var_0[var_2]].priority;
      continue;
    }

    if(self.var_3D4C[var_0[var_2]].var_698B == 0) {
      var_1[var_2] = "b " + var_0[var_2] + var_6 + " " + self.var_3D4C[var_0[var_2]].priority;
      continue;
    }

    var_1[var_2] = "r " + var_0[var_2] + var_6 + " " + self.var_3D4C[var_0[var_2]].priority;
  }

  return var_1;
}

func_7EA1(var_0) {
  var_1 = "";
  if(self.var_10AC8.var_9E9B[var_0]) {
    var_1 = var_1 + " playing";
  }

  if(gettime() > self.var_3D4C[var_0].var_698B) {
    var_1 = var_1 + " expired";
  }

  if(gettime() < self.var_10AC8.var_BFA9[var_0]) {
    var_1 = var_1 + " cantspeak";
  }

  if(var_1 == "") {
    var_1 = " valid";
  }

  return var_1;
}

func_9DF3(var_0) {
  if(getdvar("bcs_filter" + var_0, "off") == "on" || getdvar("bcs_filter" + var_0, "off") == "1") {
    return 1;
  }

  return 0;
}

func_9FD7(var_0) {
  var_1 = gettime();
  if(!self.var_10AC8.var_9E9B[var_0] && !level.isteamsaying[level.var_115E7[0]][var_0] && !level.isteamsaying[level.var_115E7[1]][var_0] && !level.isteamsaying[level.var_115E7[2]][var_0] && !level.isteamsaying[level.var_115E7[3]][var_0] && gettime() < self.var_3D4C[var_0].var_698B && gettime() > self.var_10AC8.var_BFA9[var_0]) {
    if(!func_12AE7(var_0, self.var_3D4C[var_0].var_68BA)) {
      return 1;
    }
  }

  return 0;
}

func_12AE7(var_0, var_1) {
  if(!isDefined(level.var_68BB[var_0][var_1])) {
    return 0;
  }

  if(!isDefined(self.var_10AC8.var_BFB4[var_0][var_1])) {
    return 0;
  }

  if(gettime() > self.var_10AC8.var_BFB4[var_0][var_1]) {
    return 0;
  }

  return 1;
}

func_5ACA(var_0, var_1) {
  if(!isDefined(level.var_68BB[var_0][var_1])) {
    return;
  }

  self.var_10AC8.var_BFB4[var_0][var_1] = gettime() + level.var_68BB[var_0][var_1];
}

func_29AB() {
  if(!isDefined(self)) {
    return 0;
  }

  if(!isalive(self)) {
    return 0;
  }

  if(isplayer(self)) {
    return 0;
  }

  if(!isDefined(self.var_394)) {
    return 0;
  }

  return scripts\anim\utility_common::issniperrifle(self.var_394);
}

isexposed(var_0) {
  if(distancesquared(self.origin, level.player.origin) > 2250000) {
    return 0;
  }

  if(isDefined(var_0) && var_0 && isDefined(getlocation())) {
    return 0;
  }

  var_1 = func_29A6();
  if(!isDefined(var_1)) {
    return 1;
  }

  if(!isnodecoverorconceal()) {
    return 0;
  }

  return 1;
}

isnodecoverorconceal() {
  var_0 = self.target_getindexoftarget;
  if(!isDefined(var_0)) {
    return 0;
  }

  if(issubstr(var_0.type, "Cover") || issubstr(var_0.type, "Conceal")) {
    return 1;
  }

  return 0;
}

func_10AE3(var_0) {
  if(var_0.var_C35A > 0) {
    return 1;
  }

  return 0;
}

func_9EC2() {
  var_0 = getrank();
  if(!isDefined(var_0)) {
    return 0;
  }

  if(var_0 == "sergeant" || var_0 == "lieutenant" || var_0 == "captain" || var_0 == "sergeant") {
    return 1;
  }

  return 0;
}

func_29A6() {
  if(isplayer(self)) {
    return self.target_getindexoftarget;
  }

  return scripts\anim\utility_common::func_7E28();
}

func_652B() {
  if(issentient(self) && self gettargetchargepos()) {
    return 1;
  }

  return 0;
}

func_7FD8() {
  if(func_652B()) {
    var_0 = self.var_1A53;
  } else if(self.team == "allies") {
    var_0 = self.name;
  } else {
    var_0 = undefined;
  }

  if(!isDefined(var_0)) {
    return undefined;
  }

  var_1 = strtok(var_0, " ");
  if(var_1.size < 2) {
    return var_0;
  }

  return var_1[1];
}

getrank() {
  return self.var_1A70;
}

func_7E32(var_0) {
  var_1 = _meth_8145(var_0, self.team);
  var_2 = scripts\engine\utility::getclosest(self.origin, var_1);
  return var_2;
}

_meth_8145(var_0, var_1) {
  var_2 = [];
  var_3 = getaiarray(var_1);
  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    if(var_3[var_4] == self) {
      continue;
    }

    if(!var_3[var_4] cansay(var_0)) {
      continue;
    }

    var_2[var_2.size] = var_3[var_4];
  }

  return var_2;
}

finishplayerdamage(var_0, var_1, var_2) {
  var_3 = undefined;
  if(!isDefined(var_2)) {
    var_2 = "response";
  }

  var_4 = scripts\engine\utility::array_randomize(self.var_10AC8.var_B661);
  var_0 = var_0 * var_0;
  var_1 = var_1 * var_1;
  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    if(var_4[var_5] == self) {
      continue;
    }

    if(!isalive(var_4[var_5])) {
      continue;
    }

    var_6 = distancesquared(self.origin, var_4[var_5].origin);
    if(var_6 < var_0) {
      continue;
    }

    if(var_6 > var_1) {
      continue;
    }

    if(func_9FC7(var_4[var_5])) {
      continue;
    }

    if(!var_4[var_5] cansay(var_2)) {
      continue;
    }

    var_3 = var_4[var_5];
    if(!scripts\sp\utility::func_D123()) {
      if(cansayname(var_3)) {
        break;
      }
    }
  }

  return var_3;
}

getlocation() {
  var_0 = get_all_my_locations();
  var_0 = scripts\engine\utility::array_randomize(var_0);
  if(var_0.size) {
    foreach(var_2 in var_0) {
      if(!location_called_out_ever(var_2)) {
        return var_2;
      }
    }

    foreach(var_2 in var_0) {
      if(!location_called_out_recently(var_2)) {
        return var_2;
      }
    }
  }

  return undefined;
}

getvalidlocation(var_0) {
  var_1 = get_all_my_locations();
  var_1 = scripts\engine\utility::array_randomize(var_1);
  if(var_1.size) {
    foreach(var_3 in var_1) {
      if(!location_called_out_ever(var_3) && var_0 cancalloutlocation(var_3)) {
        return var_3;
      }
    }

    foreach(var_3 in var_1) {
      if(!location_called_out_recently(var_3) && var_0 cancalloutlocation(var_3)) {
        return var_3;
      }
    }
  }

  return undefined;
}

get_all_my_locations() {
  var_0 = level.bcs_locations;
  var_1 = self getistouchingentities(var_0);
  var_2 = [];
  foreach(var_4 in var_1) {
    if(isDefined(var_4.locationaliases)) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

update_bcs_locations() {
  if(isDefined(level.bcs_locations)) {
    anim.bcs_locations = scripts\engine\utility::array_removeundefined(level.bcs_locations);
  }
}

is_in_callable_location() {
  var_0 = get_all_my_locations();
  foreach(var_2 in var_0) {
    if(!location_called_out_recently(var_2)) {
      return 1;
    }
  }

  return 0;
}

location_called_out_ever(var_0) {
  var_1 = location_get_last_callout_time(var_0);
  if(!isDefined(var_1)) {
    return 0;
  }

  return 1;
}

location_called_out_recently(var_0) {
  var_1 = location_get_last_callout_time(var_0);
  if(!isDefined(var_1)) {
    return 0;
  }

  var_2 = var_1 + level.var_68AD["threat"]["location_repeat"];
  if(gettime() < var_2) {
    return 1;
  }

  return 0;
}

location_add_last_callout_time(var_0) {
  level.locationlastcallouttimes[var_0.classname] = gettime();
}

location_get_last_callout_time(var_0) {
  if(isDefined(level.locationlastcallouttimes[var_0.classname])) {
    return level.locationlastcallouttimes[var_0.classname];
  }

  return undefined;
}

getrelativeangles(var_0) {
  var_1 = var_0.angles;
  if(!isplayer(var_0)) {
    var_2 = var_0 func_29A6();
    if(isDefined(var_2)) {
      var_1 = var_2.angles;
    }
  }

  return var_1;
}

func_101B8(var_0) {
  if(var_0 == "left" || var_0 == "right") {
    return 1;
  }

  return 0;
}

func_7E76(var_0, var_1, var_2) {
  var_3 = vectortoangles(var_2);
  var_4 = vectortoangles(var_1 - var_0);
  var_5 = var_3[1] - var_4[1];
  var_5 = var_5 + 360;
  var_5 = int(var_5) % 360;
  if(var_5 > 315 || var_5 < 45) {
    var_6 = "front";
  } else if(var_6 < 135) {
    var_6 = "right";
  } else if(var_6 < 225) {
    var_6 = "rear";
  } else {
    var_6 = "left";
  }

  return var_6;
}

func_C098(var_0) {
  var_1 = undefined;
  switch (var_0) {
    case "north":
      var_1 = "n";
      break;

    case "northwest":
      var_1 = "nw";
      break;

    case "west":
      var_1 = "w";
      break;

    case "southwest":
      var_1 = "sw";
      break;

    case "south":
      var_1 = "s";
      break;

    case "southeast":
      var_1 = "se";
      break;

    case "east":
      var_1 = "e";
      break;

    case "northeast":
      var_1 = "ne";
      break;

    case "impossible":
      var_1 = "impossible";
      break;

    default:
      break;
  }

  return var_1;
}

func_7E74(var_0, var_1) {
  var_2 = vectortoangles(var_1 - var_0);
  var_3 = var_2[1];
  var_4 = getnorthyaw();
  var_3 = var_3 - var_4;
  if(var_3 < 0) {
    var_3 = var_3 + 360;
  } else if(var_3 > 360) {
    var_3 = var_3 - 360;
  }

  if(var_3 < 22.5 || var_3 > 337.5) {
    var_5 = "north";
  } else if(var_4 < 67.5) {
    var_5 = "northwest";
  } else if(var_4 < 112.5) {
    var_5 = "west";
  } else if(var_4 < 157.5) {
    var_5 = "southwest";
  } else if(var_4 < 202.5) {
    var_5 = "south";
  } else if(var_4 < 247.5) {
    var_5 = "southeast";
  } else if(var_4 < 292.5) {
    var_5 = "east";
  } else if(var_4 < 337.5) {
    var_5 = "northeast";
  } else {
    var_5 = "impossible";
  }

  return var_5;
}

func_7E7A(var_0, var_1) {
  var_2 = distance2d(var_0, var_1);
  var_3 = 0.0254 * var_2;
  return var_3;
}

func_7E7B(var_0, var_1) {
  var_2 = func_7E7A(var_0, var_1);
  if(var_2 < 19) {
    return "10";
  }

  if(var_2 < 29) {
    return "20";
  }

  if(var_2 < 39) {
    return "30";
  }

  return "40";
}

func_7E7C(var_0, var_1) {
  var_2 = distance2d(var_0, var_1);
  var_3 = 1.57828E-05 * var_2;
  return var_3;
}

func_7E7D(var_0, var_1) {
  var_2 = func_7E7C(var_0, var_1);
  if(var_2 < 5) {
    return "4";
  }

  if(var_2 < 6) {
    return "5";
  }

  if(var_2 < 7) {
    return "6";
  }

  if(var_2 < 15) {
    return "10";
  }

  return "15";
}

func_7EC9(var_0) {
  var_1 = "undefined";
  if(var_0 == "10" || var_0 == "11") {
    var_1 = "10";
  } else if(var_0 == "12") {
    var_1 = var_0;
  } else if(var_0 == "1" || var_0 == "2") {
    var_1 = "2";
  }

  return var_1;
}

func_7E75(var_0, var_1, var_2) {
  var_3 = anglesToForward(var_0);
  var_4 = vectornormalize(var_3);
  var_5 = vectortoangles(var_4);
  var_6 = vectortoangles(var_2 - var_1);
  var_7 = var_5[1] - var_6[1];
  var_7 = var_7 + 360;
  var_7 = int(var_7) % 360;
  if(var_7 > 345 || var_7 < 15) {
    var_8 = "12";
  } else if(var_8 < 45) {
    var_8 = "1";
  } else if(var_8 < 75) {
    var_8 = "2";
  } else if(var_8 < 105) {
    var_8 = "3";
  } else if(var_8 < 135) {
    var_8 = "4";
  } else if(var_8 < 165) {
    var_8 = "5";
  } else if(var_8 < 195) {
    var_8 = "6";
  } else if(var_8 < 225) {
    var_8 = "7";
  } else if(var_8 < 255) {
    var_8 = "8";
  } else if(var_8 < 285) {
    var_8 = "9";
  } else if(var_8 < 315) {
    var_8 = "10";
  } else {
    var_8 = "11";
  }

  return var_8;
}

func_7E69(var_0, var_1) {
  var_2 = var_1[2] - var_0[2];
  var_3 = distance2d(var_0, var_1);
  var_4 = atan(var_2 / var_3);
  if(var_4 < 15 || var_4 > 55) {
    return var_4;
  }

  if(var_4 < 25) {
    return 20;
  }

  if(var_4 < 35) {
    return 30;
  }

  if(var_4 < 45) {
    return 40;
  }

  if(var_4 < 55) {
    return 50;
  }
}

markforeyeson(var_0) {
  return (var_0[1], 0 - var_0[0], var_0[2]);
}

makevehiclesolidsphere(var_0) {
  var_1 = (0, 0, 0);
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_1 = var_1 + var_0[var_2];
  }

  return (var_1[0] / var_0.size, var_1[1] / var_0.size, var_1[2] / var_0.size);
}

addconcattargetalias(var_0) {
  var_1 = "_generic";
  var_2 = undefined;
  if(var_0 func_29AB()) {
    var_1 = "_sniper";
  } else if(func_9B42(var_0)) {
    if(randomint(100) > 60) {
      var_1 = "_bot";
    } else if(isDefined(var_0.unittype) && var_0.unittype == "c6") {
      var_1 = "_c6";
    } else if(isDefined(var_0.unittype) && var_0.unittype == "c8") {
      var_1 = "_c8";
    } else if(isDefined(var_0.unittype) && var_0.unittype == "c12") {
      var_1 = "_target_mega";
    }
  }

  if(self.triggerportableradarping == level.player) {
    var_2 = "UN_plr_concat_target" + var_1;
  } else {
    var_2 = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_concat_target" + var_1;
  }

  self.var_10476[self.var_10476.size] = var_2;
}

addconcatdirectionalias(var_0, var_1) {
  var_2 = scripts\engine\utility::random(["relative", "absolute"]);
  switch (var_2) {
    case "absolute":
      var_3 = func_7E74(level.player.origin, var_1.origin);
      var_4 = func_C098(var_3);
      if(var_4 != "impossible" && var_4.size != 2) {
        if(self.triggerportableradarping == level.player) {
          var_5 = "UN_plr_concat_dir_cmpss_" + var_4;
        } else {
          var_5 = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_concat_dir_cmpss_" + var_5;
        }

        self.var_10476[self.var_10476.size] = var_5;
        break;
      }

      break;

    case "relative":
      var_6 = getrelativeangles(var_0);
      var_7 = func_7E75(var_6, var_0.origin, var_1.origin);
      var_8 = int(var_7);
      if(1 < var_8 && var_8 < 5 && scripts\engine\utility::cointoss()) {
        if(self.triggerportableradarping == level.player) {
          var_5 = "UN_plr_concat_dir_right";
        } else {
          var_5 = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_concat_dir_right";
        }

        self.var_10476[self.var_10476.size] = var_5;
        break;
      } else if(7 < var_8 && var_8 < 11 && scripts\engine\utility::cointoss()) {
        if(self.triggerportableradarping == level.player) {
          var_5 = "UN_plr_concat_dir_left";
        } else {
          var_5 = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_concat_dir_left";
        }

        self.var_10476[self.var_10476.size] = var_5;
        break;
      } else {
        if(self.triggerportableradarping == level.player) {
          var_5 = "UN_plr_concat_dir_clock_" + var_7;
        } else {
          var_5 = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_concat_dir_clock_" + var_8;
        }

        self.var_10476[self.var_10476.size] = var_5;
      }
      break;
  }
}

func_17F2(var_0) {
  if(self.triggerportableradarping == level.player) {} else {
    self.var_10476[self.var_10476.size] = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_name_" + var_0;
  }

  level.var_A9C3[self.triggerportableradarping.team] = var_0;
  level.var_A9C4[self.triggerportableradarping.team] = gettime();
}

func_180F() {
  if(!self.triggerportableradarping cansayplayername()) {
    return;
  }

  anim.var_A9CF = gettime();
  var_0 = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_name_player_" + level.player.var_29A3 + "_" + level.player.var_29AE;
  self.var_10476[self.var_10476.size] = var_0;
  self.var_299D = level.player;
}

func_1816(var_0) {
  self.var_10476[self.var_10476.size] = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_rank_" + var_0;
}

cansayname(var_0) {
  if(func_652B()) {
    return 0;
  }

  if(!isDefined(var_0.var_29AD)) {
    return 0;
  }

  if(var_0.var_28CF == 0) {
    return 0;
  }

  if(!isDefined(var_0.var_46BC)) {
    return 0;
  }

  if(self.var_46BC != var_0.var_46BC) {
    return 0;
  }

  if(func_BE4E(var_0)) {
    return 0;
  }

  var_1 = undefined;
  if(isplayer(self)) {
    var_1 = "UN_plr_name_" + var_0.var_29AD;
  } else {
    var_1 = self.var_46BC + "_" + self.npcid + "_name_" + var_0.var_29AD;
  }

  if(soundexists(var_1)) {
    return 1;
  }

  return 0;
}

func_BE4E(var_0) {
  if(level.var_A9C3[self.team] == var_0.var_29AD || gettime() - level.var_A9C4[self.team] < level.var_A9C5) {
    return 1;
  }

  return 0;
}

cansayplayername() {
  if(func_652B()) {
    return 0;
  }

  if(self == level.player) {
    return 0;
  }

  if(!isDefined(level.player.var_29AE) || !isDefined(level.player.var_29A3)) {
    return 0;
  }

  if(func_D203()) {
    return 0;
  }

  var_0 = self.var_46BC + "_" + self.npcid + "_name_player_" + level.player.var_29A3 + "_" + level.player.var_29AE;
  if(soundexists(var_0)) {
    return 1;
  }

  return 0;
}

func_D203() {
  if(!isDefined(level.var_A9CF)) {
    return 0;
  }

  if(gettime() - level.var_A9CF >= level.var_68BB["playername"]) {
    return 0;
  }

  return 1;
}

func_9FC7(var_0) {
  if(isstring(self.npcid) && isstring(var_0.npcid) && self.npcid == var_0.npcid) {
    return 1;
  }

  if(!isstring(self.npcid) && !isstring(var_0.npcid) && self.npcid == var_0.npcid) {
    return 1;
  }

  return 0;
}

func_1836(var_0, var_1) {
  var_2 = undefined;
  var_2 = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_threat_" + var_0;
  if(isDefined(var_1)) {
    var_2 = var_2 + "_" + var_1;
  }

  self.var_10476 = scripts\engine\utility::array_add(self.var_10476, var_2);
  return 1;
}

func_1840(var_0) {
  var_1 = undefined;
  var_2 = "exposed";
  if(var_0 == "group") {
    var_2 = "contact_movement";
  } else if(var_0 == "movement" && func_9B42(self.var_117E3)) {
    var_2 = "contact_movement";
    var_0 = "bot";
  }

  if(var_0 == "generic") {
    var_2 = "target";
  }

  if(isDefined(self.var_117E3) && self.var_117E3 != level.player) {
    if(var_2 == "target" && isDefined(self.var_117E3.unittype) && self.var_117E3.unittype == "c12") {
      var_0 = "c12";
    } else if(var_2 == "target" && func_9B42(self.var_117E3)) {
      var_0 = "bots";
    }
  }

  if(self.triggerportableradarping == level.player) {
    var_1 = "UN_plr_" + var_2 + "_" + var_0;
  } else if(isDefined(self.triggerportableradarping.unittype) && self.triggerportableradarping.unittype == "c6") {
    if(randomint(100) < 30 && func_9B42(self.var_117E3)) {
      var_1 = "c6_0_inform_incoming_c6";
    } else {
      var_1 = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_exposed_open";
    }
  } else {
    var_1 = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_" + var_2 + "_" + var_0;
  }

  self.var_10476[self.var_10476.size] = var_1;
  return 1;
}

func_1841() {
  if(self.triggerportableradarping == level.player) {
    var_0 = "UN_plr_order_action_suppress";
  } else {
    var_0 = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_order_action_suppress";
  }

  self.var_10476[self.var_10476.size] = var_0;
  return 1;
}

func_183D(var_0) {
  if(!scripts\sp\utility::func_D123() && self.triggerportableradarping == level.player) {
    var_1 = "UN_plr_co_dist_" + var_0;
  } else if(scripts\sp\utility::func_D123() && self.triggerportableradarping == level.var_D127) {
    var_1 = "JK_plr_co_dist_" + var_1;
  } else {
    var_1 = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_co_dist_" + var_1;
  }

  self.var_10476[self.var_10476.size] = var_1;
  return 1;
}

func_183E(var_0) {
  if(self.triggerportableradarping == level.player) {
    var_1 = "UN_plr_co_elev_" + var_0;
  } else {
    var_1 = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_co_elev_" + var_1;
  }

  self.var_10476[self.var_10476.size] = var_1;
  return 1;
}

func_1838(var_0, var_1) {
  var_2 = createechoalias(var_0, var_1);
  if(!soundexists(var_2)) {
    return 0;
  }

  self.var_10476[self.var_10476.size] = var_2;
  return 1;
}

func_183C(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  if(isalive(var_1) && func_9B42(var_1) && self.triggerportableradarping.team == "allies") {
    var_3 = "_resp_target_bot_hit";
  }

  if(scripts\engine\utility::player_is_in_jackal()) {
    return 0;
  } else if(self.triggerportableradarping == level.player) {
    if(isDefined(var_3)) {
      var_2 = "UN_plr_resp_target_bot_hit";
    } else {
      var_2 = "UN_plr_resp_ack_co_gnrc_" + var_0;
    }
  } else if(isDefined(var_3)) {
    var_2 = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_resp_target_bot_hit";
  } else {
    var_2 = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_resp_ack_co_gnrc_" + var_0;
  }

  if(!soundexists(var_2)) {
    return 0;
  }

  self.var_10476[self.var_10476.size] = var_2;
  return 1;
}

func_183B(var_0, var_1, var_2) {
  var_3 = undefined;
  foreach(var_5 in var_2.locationaliases) {
    if(issubstr(var_1, var_5)) {
      var_3 = var_5;
      break;
    }
  }

  var_7 = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_";
  var_8 = getsubstr(var_1, var_1.size - 1, var_1.size);
  var_9 = int(var_8) + 1;
  var_0A = var_7 + "callout_loc_" + var_3 + "_qa" + var_9;
  if(!soundexists(var_0A)) {
    if(randomint(100) < level.var_68AE["response"]["callout_negative"]) {
      var_0 scripts\anim\battlechatter_ai::func_1820("callout", "neg", self.triggerportableradarping, 0.9);
    } else {
      var_0 scripts\anim\battlechatter_ai::func_1820("exposed", "acquired", self.triggerportableradarping, 0.9);
    }

    var_2.qafinished = 1;
    return 0;
  }

  var_0 scripts\anim\battlechatter_ai::func_1820("callout", "QA", self.triggerportableradarping, 0.9, var_0A, var_2);
  self.var_10476[self.var_10476.size] = var_0A;
  return 1;
}

createechoalias(var_0, var_1) {
  var_2 = "_report";
  var_3 = "_echo";
  var_4 = undefined;
  if(var_1 == level.player) {
    var_5 = "plr";
  } else {
    var_5 = var_2.npcid;
  }

  if(self.triggerportableradarping == level.player) {
    var_4 = self.triggerportableradarping.var_46BC + "_plr_";
  } else {
    var_4 = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_";
  }

  var_6 = var_0.size - var_2.size;
  if(self.triggerportableradarping == level.player) {
    var_7 = self.triggerportableradarping.var_46BC + "_plr_";
    var_8 = var_7.size;
  } else {
    var_7 = self.triggerportableradarping.var_46BC + "_" + var_7 + "_";
    var_8 = var_8.size;
  }

  var_9 = getsubstr(var_0, var_8, var_6);
  var_0A = var_4 + var_9 + var_3;
  return var_0A;
}

func_1837(var_0, var_1) {
  var_2 = undefined;
  if(self.triggerportableradarping == level.player) {
    if(scripts\engine\utility::player_is_in_jackal() && var_0 == "acquired") {
      if(!isDefined(level.var_D127.var_649F)) {
        return 0;
      }
    }

    if(var_0 == "acquired" || var_0 == "sighted") {
      var_2 = self.triggerportableradarping.var_46BC + "_plr_target_" + var_0;
    } else {
      var_2 = self.triggerportableradarping.var_46BC + "_plr_callout_" + var_0 + "_" + var_1;
    }
  } else if(self.triggerportableradarping.var_46BC == "UN") {
    var_2 = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_callout_" + var_0 + "_" + var_1;
  } else if(self.triggerportableradarping.var_46BC == "JK") {
    var_3 = self.triggerportableradarping.origin[2];
    var_4 = self.var_117E3.origin[2];
    var_5 = var_3 - var_4;
    if(var_0 == "targetclock") {
      if(var_5 > 3000) {
        var_2 = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_callout_" + var_0 + "_" + var_1 + "_high";
      } else if(var_5 < -3000) {
        var_2 = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_callout_" + var_0 + "_" + var_1 + "_low";
      } else {
        var_2 = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_callout_" + var_0 + "_" + var_1;
      }
    } else {
      var_2 = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_callout_" + var_0 + "_" + var_1;
    }

    if(randomint(100) < 35) {
      var_6 = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_target_sighted";
      self.var_10476[self.var_10476.size] = var_6;
    }
  } else if(isDefined(self.triggerportableradarping.unittype) && self.triggerportableradarping.unittype == "c6") {
    if(var_0 == "cardinal") {
      switch (var_1) {
        case "ne":
        case "se":
          var_1 = "e";
          break;

        case "sw":
        case "nw":
          var_1 = "w";
          break;
      }

      var_2 = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_co_cardinal_" + var_1;
    } else {
      var_2 = "c6_0_exposed_open";
    }
  } else {
    var_2 = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_callout_" + var_0 + "_" + var_1;
  }

  self.var_10476[self.var_10476.size] = var_2;
  return 1;
}

func_1839(var_0, var_1, var_2) {
  var_3 = var_0.var_EDFB;
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_4 = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_callout_obj_" + var_3;
  if(var_2) {
    var_4 = var_4 + "_y";
  }

  var_4 = var_4 + "_" + var_1;
  if(!soundexists(var_4)) {
    return 0;
  }

  self.var_10476[self.var_10476.size] = var_4;
  return 1;
}

func_183A(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = var_0.locationaliases;
  var_5 = var_4[0];
  if(var_4.size > 1) {
    var_6 = undefined;
    var_6 = var_0 getcannedresponse(var_2);
    if(isDefined(var_6)) {
      var_5 = var_6;
    } else {
      var_5 = scripts\engine\utility::random(var_4);
    }
  }

  var_7 = undefined;
  if(isDefined(var_1) && var_1) {
    var_7 = self.triggerportableradarping getloccalloutalias("concat_loc_" + var_5);
  } else if(!isDefined(var_0.qafinished) && iscallouttypeqa(var_5, self.triggerportableradarping)) {
    var_7 = self.triggerportableradarping getqacalloutalias(var_5, 0);
  } else {
    var_7 = self.triggerportableradarping getloccalloutalias("callout_loc_" + var_5);
  }

  if(soundexists(var_7)) {
    var_3 = var_7;
  }

  if(!isDefined(var_3)) {
    return 0;
  }

  location_add_last_callout_time(var_0);
  self.var_10476[self.var_10476.size] = var_3;
  return 1;
}

func_17D1(var_0, var_1, var_2) {
  var_3 = undefined;
  if(var_1 == "hack") {
    if(isDefined(level.player.var_883D) && level.player.var_883D == "scanning") {
      var_3 = "UN_plr_inform_hack_generic";
    } else {
      return;
    }
  } else if(isDefined(var_2) && var_2 == "ally_c12_kill") {
    if(self.triggerportableradarping == level.player) {
      var_3 = "UN_plr_reaction_bot_c12";
    } else {
      var_3 = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_reaction_bot_c12";
    }
  } else {
    if(var_0 == "killfirm") {
      if(var_2 == "c6" || var_2 == "c8" || var_2 == "c12") {
        var_1 = "bot";
      }
    }

    if(var_1 == "frag") {
      var_1 = "grenade";
    }

    if(!issubstr(var_1, "weapon")) {
      var_0 = "_inform_" + var_0 + "_";
    } else {
      var_0 = "_";
    }

    if(self.triggerportableradarping == level.player) {
      if(scripts\engine\utility::player_is_in_jackal()) {
        var_3 = "JK_plr" + var_0 + var_1;
      } else {
        var_3 = "UN_plr" + var_0 + var_1;
      }
    } else {
      var_3 = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + var_0 + var_1;
    }
  }

  self.var_10476[self.var_10476.size] = var_3;
}

func_181F(var_0, var_1) {
  var_2 = undefined;
  if(scripts\engine\utility::player_is_in_jackal() && self.triggerportableradarping == level.var_D127) {
    var_2 = "JK_plr_response_" + var_0 + "_yes";
  } else if(self.triggerportableradarping == level.player) {
    var_2 = "UN_plr_response_" + var_0 + "_" + var_1;
  } else {
    var_2 = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_response_" + var_0 + "_" + var_1;
  }

  self.var_10476[self.var_10476.size] = var_2;
  return 1;
}

func_181B(var_0, var_1) {
  if(!scripts\sp\utility::func_D123()) {}

  var_2 = undefined;
  if(scripts\sp\utility::func_D123() && self.triggerportableradarping == level.var_D127) {
    if(var_0 == "movement") {
      if(!isDefined(var_1)) {
        var_1 = "generic";
      }

      var_2 = "JK_plr_enemy_" + var_0 + "_" + var_1;
    } else {
      var_2 = "JK_plr_reaction_" + var_0;
    }
  } else if(scripts\sp\utility::func_D123() && var_0 == "movement") {
    var_2 = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_enemy_movement_generic";
  } else if(!scripts\sp\utility::func_D123() && self.triggerportableradarping == level.player) {
    var_2 = "UN_plr_reaction_" + var_0 + "_" + var_1;
  } else if(isDefined(var_1)) {
    var_2 = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_reaction_" + var_0 + "_" + var_1;
  } else {
    var_2 = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_reaction_" + var_0;
  }

  self.var_10476[self.var_10476.size] = var_2;
  return 1;
}

func_17BB() {
  var_0 = undefined;
  if(self.triggerportableradarping == level.player) {
    var_0 = "UN_plr_check_fire";
  } else {
    var_0 = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_check_fire";
  }

  self.var_10476[self.var_10476.size] = var_0;
  return 1;
}

func_1832() {
  var_0 = undefined;
  if(scripts\engine\utility::player_is_in_jackal() && level.player == level.var_D127) {
    return 0;
  } else if(self.triggerportableradarping == level.player) {
    var_0 = "UN_plr_inform_taking_fire";
  } else {
    var_0 = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_inform_taking_fire";
  }

  self.var_10476[self.var_10476.size] = var_0;
  return 1;
}

func_1834(var_0, var_1) {
  var_2 = undefined;
  if(self.triggerportableradarping == level.player) {
    var_2 = "UN_plr_taunt";
  } else {
    var_2 = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_taunt";
  }

  self.var_10476[self.var_10476.size] = var_2;
  return 1;
}

func_17CF() {
  var_0 = undefined;
  if(self.triggerportableradarping == level.player) {
    var_0 = "UN_plr_hostile_burst";
  } else if(isDefined(self.triggerportableradarping.unittype) && self.triggerportableradarping.unittype == "c6") {
    var_0 = "c6_hostile_burst";
  } else {
    var_0 = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_hostile_burst";
  }

  if(soundexists(var_0)) {
    self.var_10476[self.var_10476.size] = var_0;
  }

  return 1;
}

func_1808(var_0, var_1) {
  var_2 = undefined;
  if(self.triggerportableradarping == level.player) {
    if(!scripts\sp\utility::func_D123()) {
      var_2 = "UN_plr_order_" + var_0 + "_" + var_1;
    }
  } else if(!scripts\sp\utility::func_D123()) {
    var_2 = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_order_" + var_0 + "_" + var_1;
  } else {
    var_2 = self.triggerportableradarping.var_46BC + "_" + self.triggerportableradarping.npcid + "_order_" + var_1;
  }

  if(!isDefined(var_2)) {
    return 0;
  }

  self.var_10476[self.var_10476.size] = var_2;
  return 1;
}

func_97EE(var_0) {
  if(!isDefined(self.var_10AE9[var_0].var_376A)) {
    self.var_10AE9[var_0].var_376A = 0;
  }

  if(!isDefined(self.var_10AE9[var_0].firstcontact)) {
    self.var_10AE9[var_0].firstcontact = 2000000000;
  }

  if(!isDefined(self.var_10AE9[var_0].var_A95F)) {
    self.var_10AE9[var_0].var_A95F = 0;
  }
}

func_10183(var_0) {
  self.var_10AE9[var_0].var_376A = undefined;
  self.var_10AE9[var_0].firstcontact = undefined;
  self.var_10AE9[var_0].var_A95F = undefined;
}

func_4995(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.triggerportableradarping = self;
  var_3.var_68BA = var_1;
  var_3.var_68AC = var_0;
  if(isDefined(var_2)) {
    var_3.priority = var_2;
  } else {
    var_3.priority = level.var_68B5[var_0][var_1];
  }

  var_3.var_698B = gettime() + level.var_68AF[var_0][var_1];
  return var_3;
}

func_4996() {
  var_0 = spawnStruct();
  var_0.triggerportableradarping = self;
  var_0.var_10476 = [];
  var_0.var_B3D1 = 0;
  return var_0;
}

func_D643(var_0) {
  return scripts\engine\utility::within_fov(self.origin, self.angles, var_0, 0.766);
}

func_6632(var_0) {
  return scripts\engine\utility::within_fov(self.origin, self.angles, var_0.origin, 0);
}

func_10AE2() {
  anim endon("battlechatter disabled");
  self endon("squad_deleting");
  if(self.var_10AEE != "jackal_allies") {
    return;
  }

  while(self.var_B65C <= 0) {
    wait(0.5);
  }

  wait(0.5);
  var_0 = 0;
  while(isDefined(self)) {
    if(!func_10ADE(self)) {
      var_0 = 1;
      wait(1);
      continue;
    } else if(self.var_6BB3) {
      if(!var_0) {
        wait(randomfloat(level.var_6BB8));
      }

      if(var_0) {
        var_0 = 0;
      }

      self.var_6BB3 = 0;
    } else {
      if(!var_0) {
        wait(randomfloatrange(level.var_6BB8, level.var_6BB7));
      }

      if(var_0) {
        var_0 = 0;
      }
    }

    var_1 = func_7E14(self);
    if(!isDefined(var_1)) {
      continue;
    }

    var_2 = var_1.voice;
    var_3 = getflavorburstid(self, var_2);
    var_4 = getflavorburstaliases(var_2, var_3);
    foreach(var_8, var_6 in var_4) {
      if(!var_1 func_38A3() || distance(level.player.origin, var_1.origin) > level.var_6BB2 && !isDefined(var_1.var_29B8)) {
        for(var_7 = 0; var_7 < self.var_B661.size; var_7++) {
          var_1 = func_7E14(self);
          if(!isDefined(var_1)) {
            continue;
          }

          if(var_1.voice == var_2) {
            break;
          }
        }

        if(!isDefined(var_1) || var_1.voice != var_2) {
          break;
        }
      }

      thread playflavorburstline(var_1, var_6);
      self waittill("burst_line_done");
      if(var_8 != var_4.size - 1) {
        wait(randomfloatrange(level.var_6BB6, level.var_6BB5));
      }
    }
  }
}

func_10ADE(var_0) {
  var_1 = 0;
  foreach(var_3 in var_0.var_B661) {
    if(isalive(var_3) && var_3.var_10AC8.var_10AEE == "jackal_allies") {
      if(isDefined(self.var_9F6B) && self.var_9F6B) {
        return 0;
      }
    }

    if(var_3 == level.player) {
      continue;
    }

    if(!isDefined(var_3.team)) {
      return var_1;
    }

    if(var_3 func_38A3()) {
      var_1 = 1;
      break;
    }
  }

  return var_1;
}

func_38A3() {
  var_0 = 0;
  if(isalive(self) && self.var_10AC8.var_10AEE == "jackal_allies") {
    if(!isDefined(level.var_C52F) || isDefined(level.var_C52F) && !level.var_C52F) {
      if(!scripts\engine\utility::player_is_in_jackal()) {
        return 0;
      }
    }
  }

  if(self != level.player && isalive(self) && level.var_6EE9[self.team] && func_13528() && isDefined(self.var_6EE9) && self.var_6EE9) {
    var_0 = 1;
  }

  return var_0;
}

func_13528() {
  if(isDefined(level.var_6EED) && isDefined(level.var_6EED[self.voice]) && level.var_6EED[self.voice]) {
    return 1;
  }

  return 0;
}

func_7E14(var_0) {
  var_1 = undefined;
  var_2 = scripts\engine\utility::get_array_of_farthest(level.player.origin, var_0.var_B661);
  foreach(var_4 in var_2) {
    if(var_4 func_38A3()) {
      var_1 = var_4;
      if(!isDefined(var_0.var_6BB4)) {
        break;
      }

      if(isDefined(var_0.var_6BB4) && var_0.var_6BB4 == var_1.unique_id) {
        continue;
      }
    }
  }

  if(isDefined(var_1)) {
    var_0.var_6BB4 = var_1.unique_id;
  }

  return var_1;
}

getflavorburstid(var_0, var_1) {
  var_2 = scripts\engine\utility::array_randomize(level.var_6EE9[var_1]);
  if(level.var_6EEC.size >= var_2.size) {
    anim.var_6EEC = [];
  }

  var_3 = undefined;
  foreach(var_5 in var_2) {
    var_3 = var_5;
    if(!func_6EEE(var_3)) {
      break;
    }
  }

  level.var_6EEC[level.var_6EEC.size] = var_3;
  return var_3;
}

func_6EEE(var_0) {
  if(!level.var_6EEC.size) {
    return 0;
  }

  var_1 = 0;
  foreach(var_3 in level.var_6EEC) {
    if(var_3 == var_0) {
      var_1 = 1;
      break;
    }
  }

  return var_1;
}

getflavorburstaliases(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_3 = var_2;
  var_4 = [];
  for(;;) {
    if(issubstr(var_0, "jackal")) {
      var_5 = var_3 * 10;
    } else {
      var_5 = var_3;
    }

    var_6 = "FB_" + level.var_46BD[var_0] + "_" + var_1 + "_" + var_5;
    var_3++;
    if(soundexists(var_6)) {
      var_4[var_4.size] = var_6;
      continue;
    }

    break;
  }

  return var_4;
}

playflavorburstline(var_0, var_1) {
  anim endon("battlechatter disabled");
  var_2 = undefined;
  if(isDefined(var_0.var_29B8) && var_0.var_29B8) {
    if(!scripts\engine\utility::player_is_in_jackal()) {
      if(isDefined(level.var_C52F) && level.var_C52F) {
        var_2 = spawn("script_origin", level.player getEye());
        var_2 linkto(level.player);
      } else if(isDefined(self)) {
        self notify("burst_line_done");
        return;
      } else {
        return;
      }
    } else {
      var_3 = level.player gettagorigin("tag_cockpit_light_monitor2");
      var_2 = spawn("script_origin", var_3);
      var_2 linkto(level.player);
    }
  } else {
    var_2 = spawn("script_origin", var_0 gettagorigin("j_head"));
    var_2 linkto(var_0);
  }

  var_2 playSound(var_1, var_1, 1);
  var_2 waittill(var_1);
  var_2 delete();
  if(isDefined(self)) {
    self notify("burst_line_done");
  }
}

func_6EE8(var_0, var_1) {
  self endon("burst_line_done");
  wait(0.05);
}

battlechatter_canprint() {
  return 0;
}

battlechatter_canprintdump() {
  return 0;
}

battlechatter_print(var_0) {
  if(var_0.size <= 0) {
    return;
  }

  if(!battlechatter_canprint()) {
    return;
  }

  var_1 = "^5 ";
  if(func_652B()) {
    var_1 = "^6 ";
  }

  foreach(var_3 in var_0) {}
}

battlechatter_printdump(var_0, var_1) {}

getaliastypefromsoundalias(var_0) {
  var_1 = self.var_46BC + "_" + self.npcid + "_";
  var_2 = getsubstr(var_0, var_1.size, var_0.size);
  return var_2;
}

battlechatter_printdumpline(var_0, var_1, var_2) {
  if(scripts\engine\utility::flag(var_2)) {
    scripts\engine\utility::flag_wait(var_2);
  }

  scripts\engine\utility::flag_set(var_2);
  scripts\engine\utility::flag_clear(var_2);
}

func_29A5() {
  for(var_0 = 0; var_0 < level.bcs_locations.size; var_0++) {
    var_1 = level.bcs_locations[var_0].locationaliases;
    if(!isDefined(var_1)) {
      continue;
    }

    var_2 = "";
    foreach(var_4 in var_1) {
      var_2 = var_2 + var_4;
    }

    thread func_5B71("Location: " + var_2, level.bcs_locations[var_0] getorigin(), (0, 0, 8), (1, 1, 1));
  }
}

func_5B71(var_0, var_1, var_2, var_3) {
  for(;;) {
    if(distancesquared(level.player.origin, var_1) > 4194304) {
      wait(0.1);
      continue;
    }

    wait(0.05);
  }
}

func_5B70(var_0, var_1, var_2) {
  var_3 = var_0 getorigin();
  for(;;) {
    if(distancesquared(level.player.origin, var_3) > 4194304) {
      wait(0.1);
      continue;
    }

    var_4 = func_7E74(level.player.origin, var_3);
    var_4 = func_C098(var_4);
    var_5 = func_7E75(level.player.angles, level.player.origin, var_3);
    var_6 = var_4 + ", " + var_5 + ":00";
    wait(0.05);
  }
}

func_E25A(var_0, var_1) {
  var_2 = getaiarray(var_0);
  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];
    if(!isalive(var_4)) {
      continue;
    }

    if(!isDefined(var_4.var_28CF)) {
      continue;
    }

    var_4.var_BFA9[var_1] = gettime() + 350;
    var_4.var_10AC8.var_BFA9[var_1] = gettime() + 350;
  }
}

func_13527() {
  self endon("death");
  if(self.voice == "british") {
    return 1;
  }

  return 0;
}

func_740F() {
  if(!func_3844()) {
    return 0;
  }

  func_5ACA("reaction", "friendlyfire");
  thread func_D503();
  return 1;
}

func_3844(var_0) {
  if(isDefined(self.var_7411)) {
    return 0;
  }

  if(isDefined(self.melee)) {
    if(isDefined(self.melee.var_9904)) {
      if(self.melee.var_9904) {
        return 0;
      }
    }
  }

  if(!isDefined(self.var_3D4C)) {
    return 0;
  }

  if(!isDefined(self.var_3D4C["reaction"]) || !isDefined(self.var_3D4C["reaction"].var_68BA)) {
    return 0;
  }

  if(self.var_3D4C["reaction"].var_68BA != "friendlyfire") {
    return 0;
  }

  if(gettime() > self.var_3D4C["reaction"].var_698B) {
    return 0;
  }

  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    if(isDefined(self.var_10AC8.var_BFB4["reaction"]["friendlyfire"])) {
      if(gettime() < self.var_10AC8.var_BFB4["reaction"]["friendlyfire"]) {
        return 0;
      }
    }
  }

  return 1;
}

func_9B42(var_0) {
  var_1 = 0;
  if(isDefined(var_0) && isalive(var_0) && var_0 != level.player && isDefined(var_0.unittype)) {
    if(var_0.unittype == "c6" || var_0.unittype == "c8" || var_0.unittype == "c12") {
      var_1 = 1;
    }
  }

  return var_1;
}