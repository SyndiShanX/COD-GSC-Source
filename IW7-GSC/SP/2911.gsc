/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\2911.gsc
*********************************************/

func_96D7() {
  func_965A();
  precacheshellshock("default_nosound");
  precachesuit("normal_sp");
  precachemodel("vm_hero_protagonist_helmet");
  precachemodel("hero_jackal_helmet_a");
  func_F5FF();
  scripts\sp\thermal::func_977D();
  scripts\sp\gameskill::func_95F9();
  scripts\sp\gameskill::func_D3A6();
  scripts\sp\footsteps::func_4FF0();
  lib_0B60::func_96DC();
  scripts\sp\slowmo_init::func_1032A();
  setsaveddvar("cg_useplayerbreathsys", 1);
  foreach(var_1 in level.players) {
    var_1.maxhealth = level.player.health;
    var_1.var_9B34 = 0;
    var_1 func_16BC(::func_FE41);
    var_1 thread scripts\sp\gameskill::playerhealthregen();
    var_1 thread func_D37B();
    level.player thread lib_0B2A::func_B9D3();
    lib_0E42::init();
  }

  if(!level.console) {
    level.player scripts\sp\utility::func_65E0("script_allow_showviewmodel");
    if(!is_jackal_only_mission()) {
      thread handle_fov_viewmodel();
    }
  }
}

func_F5FF() {
  level.player setsuit("normal_sp");
  switch (level.script) {
    case "shipcrib_moon":
    case "phstreets":
    case "phparade":
    case "shipcrib_epilogue":
    case "shipcrib_prisoner":
    case "shipcrib_rogue":
    case "shipcrib_titan":
    case "shipcrib_europa":
      setsaveddvar("spaceshipPilotModel", "viewmodel_base_animated");
      level.player func_8573("nopack_nohelmet_shadow");
      level.player func_84C7("currentViewModel", "viewmodel_base_viewhands_iw7_naval");
      level.player givegoproattachments("viewmodel_base_viewhands_iw7_naval");
      level.player func_8574("body_hero_protagonist_vm_legs_naval");
      break;

    case "phspace":
      setsaveddvar("spaceshipPilotModel", "viewmodel_base_animated_naval");
      level.player func_8573("default_character_shadow");
      level.player func_84C7("currentViewModel", "viewmodel_base_viewhands_iw7_naval");
      level.player givegoproattachments("viewmodel_base_viewhands_iw7_naval");
      level.player func_8574("body_hero_protagonist_vm_legs_naval");
      break;

    case "titanjackal":
    case "titan":
      setsaveddvar("spaceshipPilotModel", "viewmodel_base_animated_desert");
      level.player func_8573("default_character_shadow");
      level.player func_84C7("currentViewModel", "viewmodel_base_viewhands_iw7_desert");
      level.player givegoproattachments("viewmodel_base_viewhands_iw7_desert");
      level.player func_8574("body_hero_protagonist_vm_legs_desert");
      break;

    case "sa_assassination":
      setsaveddvar("spaceshipPilotModel", "viewmodel_body_mp_stryker_2");
      level.player func_8573("default_character_shadow");
      level.player func_84C7("currentViewModel", "viewmodel_base_viewhands_iw7");
      level.player givegoproattachments("viewmodel_base_viewhands_iw7");
      level.player func_8574("body_hero_protagonist_vm_legs");
      break;

    default:
      setsaveddvar("spaceshipPilotModel", "viewmodel_base_animated");
      level.player func_8573("default_character_shadow");
      level.player func_84C7("currentViewModel", "viewmodel_base_viewhands_iw7");
      level.player givegoproattachments("viewmodel_base_viewhands_iw7");
      level.player func_8574("body_hero_protagonist_vm_legs");
      break;
  }
}

func_FE41() {
  self waittill("death");
  if(isDefined(self.var_10956)) {
    return;
  }

  if(getdvar("r_texturebits") == "16") {
    return;
  }

  self shellshock("default_nosound", 3);
}

func_D37B() {
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_3, var_3, var_3, var_3, var_5);
    if(isDefined(self.var_10954)) {
      continue;
    }

    if(scripts\engine\utility::getdamagetype(var_4) != "bullet") {
      var_6 = -32 * var_2 + self.origin;
    }

    if(isDefined(var_5) && getweaponbasename(var_5) == "iw7_sonic") {
      func_20B3();
    }
  }
}

func_20B3() {
  self shellshock("deafened", 2.5);
}

func_965A() {
  if(!scripts\engine\utility::add_init_script("level_players", ::func_965A)) {
    return;
  }

  level.var_B8D0 = 0;
  scripts\engine\utility::flag_init("missionfailed");
  level.players = getEntArray("player", "classname");
  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    level.players[var_0].unique_id = "player" + var_0;
  }

  level.player = level.players[0];
  level.var_5012 = 190;
  setsaveddvar("g_speed", level.var_5012);
  thread func_CFF8();
}

func_D023() {
  for(;;) {
    var_0 = getdvarint("player_died_recently", 0);
    if(var_0 > 0) {
      var_0 = var_0 - 5;
      setdvar("player_died_recently", var_0);
    }

    wait(5);
  }
}

func_CFF8() {
  setdvar("player_died_recently", "0");
  thread func_D023();
  level scripts\sp\utility::func_178D(scripts\engine\utility::flag_wait, "missionfailed");
  level.player scripts\sp\utility::func_178D(scripts\sp\utility::func_137AA, "death");
  scripts\sp\utility::func_57D6();
  var_0 = [];
  var_0[0] = 70;
  var_0[1] = 30;
  var_0[2] = 0;
  var_0[3] = 0;
  setdvar("player_died_recently", var_0[level.var_7683]);
}

func_16BC(var_0) {
  if(!isDefined(self.var_4E0E)) {
    self.var_4E0E = [];
    thread func_4E0E();
  }

  self.var_4E0E = var_0;
}

func_4E0E() {
  foreach(var_1 in self.var_4E0E) {
    thread[[var_1]]();
  }
}

func_51E7() {}

handle_fov_viewmodel() {
  level.player endon("death");
  level.player scripts\sp\utility::func_65E0("fov_vm_hide");
  if(!levelrequiresfovhandling()) {
    return;
  }

  var_0 = 1.4;
  level.player scripts\sp\utility::func_65E1("script_allow_showviewmodel");
  for(;;) {
    if(!level.player scripts\sp\utility::func_65DB("script_allow_showviewmodel")) {
      level.player func_818A();
      level.player scripts\sp\utility::func_65E1("fov_vm_hide");
      level.player scripts\sp\utility::func_65E3("script_allow_showviewmodel");
    }

    var_1 = getdvarfloat("com_fovUserScale");
    if(var_1 >= var_0 && level.player getcurrentweapon() == "iw7_gunless") {
      if(!level.player scripts\sp\utility::func_65DB("fov_vm_hide")) {
        level.player func_818A();
        level.player scripts\sp\utility::func_65E1("fov_vm_hide");
      }
    } else if(level.player scripts\sp\utility::func_65DB("fov_vm_hide")) {
      level.player giveperkoffhand();
      level.player scripts\sp\utility::func_65DD("fov_vm_hide");
    }

    wait(0.05);
  }
}

is_jackal_only_mission() {
  return level.script == "phspace" || level.script == "moonjackal" || issubstr(level.script, "ja_");
}

levelrequiresfovhandling() {
  return level.script == "yard" || level.script == "prisoner" || level.script == "marsbase" || level.script == "marscrash" || level.script == "heist" || level.script == "phparade" || level.script == "moon_port" || issubstr(level.script, "shipcrib");
}