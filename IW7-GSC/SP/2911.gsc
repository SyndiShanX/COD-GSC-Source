/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2911.gsc
**************************************/

_id_96D7() {
  _id_965A();
  precacheshellshock("default_nosound");
  precachesuit("normal_sp");
  precachemodel("vm_hero_protagonist_helmet");
  precachemodel("hero_jackal_helmet_a");
  _id_F5FF();
  scripts\sp\thermal::_id_977D();
  scripts\sp\gameskill::_id_95F9();
  scripts\sp\gameskill::_id_D3A6();
  scripts\sp\footsteps::_id_4FF0();
  _id_0B60::_id_96DC();
  scripts\sp\slowmo_init::_id_1032A();
  setsaveddvar("cg_useplayerbreathsys", 1);

  foreach(var_1 in level.players) {
    var_1.maxhealth = level.player.health;
    var_1._id_9B34 = 0;
    var_1 _id_16BC(::_id_FE41);
    var_1 thread scripts\sp\gameskill::playerhealthregen();
    var_1 thread _id_D37B();
    level.player thread _id_0B2A::_id_B9D3();
    _id_0E42::init();
  }

  if(!level.console) {
    level.player scripts\sp\utility::_id_65E0("script_allow_showviewmodel");

    if(!is_jackal_only_mission())
      thread handle_fov_viewmodel();
  }
}

_id_F5FF() {
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
      level.player _meth_8573("nopack_nohelmet_shadow");
      level.player _meth_84C7("currentViewModel", "viewmodel_base_viewhands_iw7_naval");
      level.player setviewmodel("viewmodel_base_viewhands_iw7_naval");
      level.player _meth_8574("body_hero_protagonist_vm_legs_naval");
      break;
    case "phspace":
      setsaveddvar("spaceshipPilotModel", "viewmodel_base_animated_naval");
      level.player _meth_8573("default_character_shadow");
      level.player _meth_84C7("currentViewModel", "viewmodel_base_viewhands_iw7_naval");
      level.player setviewmodel("viewmodel_base_viewhands_iw7_naval");
      level.player _meth_8574("body_hero_protagonist_vm_legs_naval");
      break;
    case "titanjackal":
    case "titan":
      setsaveddvar("spaceshipPilotModel", "viewmodel_base_animated_desert");
      level.player _meth_8573("default_character_shadow");
      level.player _meth_84C7("currentViewModel", "viewmodel_base_viewhands_iw7_desert");
      level.player setviewmodel("viewmodel_base_viewhands_iw7_desert");
      level.player _meth_8574("body_hero_protagonist_vm_legs_desert");
      break;
    case "sa_assassination":
      setsaveddvar("spaceshipPilotModel", "viewmodel_body_mp_stryker_2");
      level.player _meth_8573("default_character_shadow");
      level.player _meth_84C7("currentViewModel", "viewmodel_base_viewhands_iw7");
      level.player setviewmodel("viewmodel_base_viewhands_iw7");
      level.player _meth_8574("body_hero_protagonist_vm_legs");
      break;
    default:
      setsaveddvar("spaceshipPilotModel", "viewmodel_base_animated");
      level.player _meth_8573("default_character_shadow");
      level.player _meth_84C7("currentViewModel", "viewmodel_base_viewhands_iw7");
      level.player setviewmodel("viewmodel_base_viewhands_iw7");
      level.player _meth_8574("body_hero_protagonist_vm_legs");
      break;
  }
}

_id_FE41() {
  self waittill("death");

  if(isDefined(self._id_10956)) {
    return;
  }
  if(getDvar("r_texturebits") == "16") {
    return;
  }
  self shellshock("default_nosound", 3);
}

_id_D37B() {
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_3, var_3, var_3, var_3, var_5);

    if(isDefined(self._id_10954)) {
      continue;
    }
    if(scripts\engine\utility::getdamagetype(var_4) != "bullet")
      var_6 = -32 * var_2 + self.origin;

    if(isDefined(var_5) && getweaponbasename(var_5) == "iw7_sonic")
      _id_20B3();
  }
}

_id_20B3() {
  self shellshock("deafened", 2.5);
}

_id_965A() {
  if(!scripts\engine\utility::add_init_script("level_players", ::_id_965A)) {
    return;
  }
  level._id_B8D0 = 0;
  scripts\engine\utility::flag_init("missionfailed");
  level.players = getEntArray("player", "classname");

  for(var_0 = 0; var_0 < level.players.size; var_0++)
    level.players[var_0].unique_id = "player" + var_0;

  level.player = level.players[0];
  level._id_5012 = 190;
  setsaveddvar("g_speed", level._id_5012);
  thread _id_CFF8();
}

_id_D023() {
  for(;;) {
    var_0 = getdvarint("player_died_recently", 0);

    if(var_0 > 0) {
      var_0 = var_0 - 5;
      setDvar("player_died_recently", var_0);
    }

    wait 5;
  }
}

_id_CFF8() {
  setDvar("player_died_recently", "0");
  thread _id_D023();
  level scripts\sp\utility::_id_178D(scripts\engine\utility::flag_wait, "missionfailed");
  level.player scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "death");
  scripts\sp\utility::_id_57D6();
  var_0 = [];
  var_0[0] = 70;
  var_0[1] = 30;
  var_0[2] = 0;
  var_0[3] = 0;
  setDvar("player_died_recently", var_0[level._id_7683]);
}

_id_16BC(var_0) {
  if(!isDefined(self._id_4E0E)) {
    self._id_4E0E = [];
    thread _id_4E0E();
  }

  self._id_4E0E = var_0;
}

_id_4E0E() {
  foreach(var_1 in self._id_4E0E)
  thread[[var_1]]();
}

_id_51E7() {}

handle_fov_viewmodel() {
  level.player endon("death");
  level.player scripts\sp\utility::_id_65E0("fov_vm_hide");

  if(!levelrequiresfovhandling()) {
    return;
  }
  var_0 = 1.4;
  level.player scripts\sp\utility::_id_65E1("script_allow_showviewmodel");

  for(;;) {
    if(!level.player scripts\sp\utility::_id_65DB("script_allow_showviewmodel")) {
      level.player _meth_818A();
      level.player scripts\sp\utility::_id_65E1("fov_vm_hide");
      level.player scripts\sp\utility::_id_65E3("script_allow_showviewmodel");
    }

    var_1 = getdvarfloat("com_fovUserScale");

    if(var_1 >= var_0 && level.player getcurrentweapon() == "iw7_gunless") {
      if(!level.player scripts\sp\utility::_id_65DB("fov_vm_hide")) {
        level.player _meth_818A();
        level.player scripts\sp\utility::_id_65E1("fov_vm_hide");
      }
    } else if(level.player scripts\sp\utility::_id_65DB("fov_vm_hide")) {
      level.player showviewmodel();
      level.player scripts\sp\utility::_id_65DD("fov_vm_hide");
    }

    wait 0.05;
  }
}

is_jackal_only_mission() {
  return level.script == "phspace" || level.script == "moonjackal" || issubstr(level.script, "ja_");
}

levelrequiresfovhandling() {
  return level.script == "yard" || level.script == "prisoner" || level.script == "marsbase" || level.script == "marscrash" || level.script == "heist" || level.script == "phparade" || level.script == "moon_port" || issubstr(level.script, "shipcrib");
}