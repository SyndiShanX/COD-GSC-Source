/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3497.gsc
***************************************/

init() {
  level.func_A4AD = [];
  level.func_A4AD["juggernaut"] = spawnStruct();
  level.func_A4AD["juggernaut"].func_10A41 = "used_juggernaut";
  level.func_A4AD["juggernaut_recon"] = spawnStruct();
  level.func_A4AD["juggernaut_recon"].func_10A41 = "used_juggernaut_recon";
  level.func_A4AD["juggernaut_maniac"] = spawnStruct();
  level.func_A4AD["juggernaut_maniac"].func_10A41 = "used_juggernaut_maniac";
  level thread func_13AB0();
}

givejuggernaut(var_00) {
  self endon("death");
  self endon("disconnect");
  wait 0.05;

  if(isDefined(self.lightarmorhp))
    scripts\mp\perks\perkfunctions::unsetlightarmor();

  scripts\mp\weapons::func_5608();

  if(scripts\mp\utility\game::_hasperk("specialty_explosivebullets"))
    scripts\mp\utility\game::removeperk("specialty_explosivebullets");

  self.health = self.maxhealth;
  var_01 = 1;

  switch (var_00) {
    case "juggernaut":
      self.isjuggernaut = 1;
      self.func_A4AA = 0.8;
      scripts\mp\class::giveloadout(self.pers["team"], var_00, 0);
      self.movespeedscaler = 0.8;
      scripts\mp\utility\game::giveperk("specialty_scavenger");
      scripts\mp\utility\game::giveperk("specialty_quickdraw");
      scripts\mp\utility\game::giveperk("specialty_detectexplosive");
      scripts\mp\utility\game::giveperk("specialty_sharp_focus");
      scripts\mp\utility\game::giveperk("specialty_radarjuggernaut");
      break;
    case "juggernaut_recon":
      self.isjuggernautrecon = 1;
      self.func_A4AA = 0.8;
      scripts\mp\class::giveloadout(self.pers["team"], var_00);
      self.movespeedscaler = 0.8;
      scripts\mp\utility\game::giveperk("specialty_scavenger");
      scripts\mp\utility\game::giveperk("specialty_coldblooded");
      scripts\mp\utility\game::giveperk("specialty_noscopeoutline");
      scripts\mp\utility\game::giveperk("specialty_detectexplosive");
      scripts\mp\utility\game::giveperk("specialty_sharp_focus");
      scripts\mp\utility\game::giveperk("specialty_radarjuggernaut");

      if(!isagent(self)) {
        self makeportableradar(self);
        scripts\mp\missions::processchallenge("ch_airdrop_juggernaut_recon");
      }

      break;
    case "juggernaut_maniac":
      self.isjuggernautmaniac = 1;
      self.func_A4AA = 1.15;
      scripts\mp\class::giveloadout(self.pers["team"], var_00, 0);
      scripts\mp\utility\game::giveperk("specialty_blindeye");
      scripts\mp\utility\game::giveperk("specialty_coldblooded");
      scripts\mp\utility\game::giveperk("specialty_noscopeoutline");
      scripts\mp\utility\game::giveperk("specialty_detectexplosive");
      scripts\mp\utility\game::giveperk("specialty_marathon");
      scripts\mp\utility\game::giveperk("specialty_falldamage");
      self.movespeedscaler = 1.15;
      break;
    default:
      var_01 = self[[level.func_B331]](var_00);
      break;
  }

  if(func_CA4E("specialty_hardline"))
    scripts\mp\utility\game::giveperk("specialty_hardline");

  scripts\mp\weapons::updatemovespeedscale();
  self disableweaponpickup();

  if(!isagent(self)) {
    if(var_01) {
      self setclientomnvar("ui_juggernaut", 1);
      thread scripts\mp\utility\game::teamplayercardsplash(level.func_A4AD[var_00].func_10A41, self);
      thread func_A4A9();
      thread func_139F1();
      thread func_13A13();
    }
  }

  if(self.streaktype == "specialist")
    thread scripts\mp\killstreaks\killstreaks::func_41C0();

  thread func_A4AC();

  if(isDefined(self.carryflag)) {
    wait 0.05;
    self attach(self.carryflag, "J_spine4", 1);
  }

  level notify("juggernaut_equipped", self);
  scripts\mp\matchdata::logkillstreakevent(var_00, self.origin);
}

func_CA4E(var_00) {
  var_01 = self.pers["loadoutPerks"];

  foreach(var_03 in var_01) {
    if(var_03 == var_00)
      return 1;
  }

  return 0;
}

func_A4A9() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("jugg_removed");

  for(;;) {
    wait 3.0;
    scripts\mp\utility\game::playplayerandnpcsounds(self, "juggernaut_breathing_player", "juggernaut_breathing_sound");
  }
}

func_13AB0() {
  level endon("game_ended");

  for(;;) {
    level waittill("host_migration_end");

    foreach(var_01 in level.players) {
      if(isai(var_01))
        continue;
      else {
        if(var_01 scripts\mp\utility\game::isjuggernaut() && !(isDefined(var_1.isjuggernautlevelcustom) && var_1.isjuggernautlevelcustom)) {
          var_01 setclientomnvar("ui_juggernaut", 1);
          continue;
        }

        var_01 setclientomnvar("ui_juggernaut", 0);
      }
    }
  }
}

func_A4AC() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("jugg_removed");
  thread func_A4AB();
  scripts\engine\utility::waittill_any("death", "joined_team", "joined_spectators", "lost_juggernaut");
  self _meth_80DB();
  self.isjuggernaut = 0;
  self.isjuggernautdef = 0;
  self.isjuggernautgl = 0;
  self.isjuggernautrecon = 0;
  self.isjuggernautmaniac = 0;
  self.isjuggernautlevelcustom = 0;

  if(isplayer(self))
    self setclientomnvar("ui_juggernaut", 0);

  self unsetperk("specialty_radarjuggernaut", 1);
  self notify("jugg_removed");
}

func_A4AB() {
  self endon("disconnect");
  self endon("jugg_removed");
  level waittill("game_ended");

  if(isplayer(self))
    self setclientomnvar("ui_juggernaut", 0);
}

func_F766() {
  if(isDefined(self.headmodel)) {
    self detach(self.headmodel, "");
    self.headmodel = undefined;
  }

  self setModel("mp_fullbody_juggernaut_heavy_black");
  self setviewmodel("viewhands_juggernaut_ally");
  self give_explosive_touch_on_revived("vestheavy");
}

func_F767() {
  if(isDefined(self.headmodel)) {
    self detach(self.headmodel, "");
    self.headmodel = undefined;
  }

  self setModel("mp_fullbody_heavy");
  self setviewmodel("viewhands_juggernaut_ally");
  self attach("mp_warfighter_head_1", "", 1);
  self.headmodel = "mp_warfighter_head_1";
  self give_explosive_touch_on_revived("nylon");
}

func_55F4() {
  if(scripts\mp\utility\game::isjuggernaut()) {
    self.func_A4A4 = 1;
    self setclientomnvar("ui_juggernaut", 0);
  }
}

func_626C() {
  if(scripts\mp\utility\game::isjuggernaut()) {
    self.func_A4A4 = undefined;
    self setclientomnvar("ui_juggernaut", 1);
  }
}

func_139F1() {
  self endon("death");
  self endon("disconnect");
  self endon("jugg_removed");
  level endon("game_ended");

  for(;;) {
    if(!isDefined(self.func_A4A4) && scripts\mp\utility\game::isusingremote()) {
      self waittill("black_out_done");
      func_55F4();
    }

    wait 0.05;
  }
}

func_13A13() {
  self endon("death");
  self endon("disconnect");
  self endon("jugg_removed");
  level endon("game_ended");

  for(;;) {
    if(isDefined(self.func_A4A4) && !scripts\mp\utility\game::isusingremote())
      func_626C();

    wait 0.05;
  }
}

func_988F(var_00, var_01, var_02, var_03) {
  level.func_B331 = var_00;
  level.func_B333 = var_01;
  level.func_B332 = var_03;
  game["allies_model"]["JUGGERNAUT_CUSTOM"] = var_02;
  game["axis_model"]["JUGGERNAUT_CUSTOM"] = var_02;
}