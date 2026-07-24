/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\moon_port\moon_port_fob.gsc
*******************************************************/

_id_71FB() {}

_id_71E7() {
  scripts\engine\utility::flag_init("fob_halls_cafe_enemies_clear");
  scripts\engine\utility::flag_init("fob_halls_end");
  scripts\engine\utility::flag_init("fob_arrived");
  scripts\engine\utility::flag_init("flag_mco_at_fob_start");
  scripts\engine\utility::flag_init("fob_doors_open");
  scripts\engine\utility::flag_init("into_fob");
  createthreatbiasgroup("cafe_enemies");
  createthreatbiasgroup("fob_guards");
  createthreatbiasgroup("cafe_enemies_ledge");
}

_id_71F2() {
  scripts\sp\maps\moon_port\moon_port_util::_id_BC53("start_fob_halls");
  var_0 = ["marineCO", "salter", "eth3n", "marine1", "marine2"];
  scripts\sp\maps\moon_port\moon_port_util::_id_BC05("start_fob_halls", var_0);
  wait 0.1;
  scripts\engine\utility::flag_set("concourse_tigris_dialogue_finished");
  scripts\engine\utility::flag_set("into_fob");
  scripts\sp\utility::_id_15F5("pre_fob_color1");
  thread _id_10669();
}

_id_71ED() {
  if(getdvarint("kleenex") == 1)
    scripts\sp\utility::_id_A6F2();

  scripts\engine\utility::flag_wait("into_fob");
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0)
  var_2 _meth_81D0();

  thread _id_71E6();
  thread _id_7202();
  thread _id_71EA();
  thread scripts\sp\maps\moon_port\moon_port_anim::_id_71FE();
  thread scripts\sp\maps\moon_port\moon_port_anim::_id_71FF();
  thread scripts\sp\maps\moon_port\moon_port_anim::_id_71F0();
  thread scripts\sp\maps\moon_port\moon_port_anim::_id_71F1();
  thread scripts\sp\maps\moon_port\moon_port_anim::_id_71EE();
  thread scripts\sp\maps\moon_port\moon_port_anim::_id_71EF();
  thread scripts\sp\maps\moon_port\moon_port_anim::_id_7205();
  thread scripts\sp\maps\moon_port\moon_port_anim::_id_7206();
  setthreatbias("fob_guards", "cafe_enemies", 10000);
  setthreatbias("fob_guards", "cafe_enemies_ledge", 10000);
  setthreatbias("cafe_enemies", "fob_guards", 10000);
  setthreatbias("cafe_enemies_ledge", "fob_guards", 10000);
  scripts\engine\utility::flag_wait("fob_halls_player_jumped_up");
  thread _id_71F8();
  thread _id_71DD();

  while(scripts\sp\utility::_id_77DB("fob_cafe_enemies") + scripts\sp\utility::_id_77DB("fob_cafe_enemy_bots") > 2)
    wait 0.1;

  var_4 = scripts\sp\utility::_id_77DA("fob_cafe_enemies");
  var_5 = scripts\sp\utility::_id_77DA("fob_cafe_enemy_bots");
  var_4 = scripts\sp\utility::_id_22A2(var_4, var_5);

  foreach(var_7 in var_4)
  var_7.attackeraccuracy = 10;

  while(scripts\sp\utility::_id_77DB("fob_cafe_enemies") + scripts\sp\utility::_id_77DB("fob_cafe_enemy_bots") > 0)
    wait 0.1;

  scripts\engine\utility::flag_set("fob_halls_cafe_enemies_clear");
  wait 0.65;
  scripts\sp\utility::_id_28D7("allies");
  scripts\sp\utility::_id_28D7("axis");
  thread _id_71EC();
  var_9 = getaiarray("axis");
  scripts\sp\utility::_id_228A(var_9);
  wait 0.5;
  scripts\sp\utility::_id_15F5("fob_halls_squad_end");
  wait 1.5;
  level.player scripts\sp\utility::_id_F526("relaxed");
  var_10 = getEnt("fob_arrive_volume", "targetname");

  foreach(var_12 in level.allies)
  var_12 thread _id_3B1B(var_10);

  scripts\engine\utility::flag_wait("fob_arrived");
  thread _id_71E9();
}

_id_71DE() {
  wait 10;
  setthreatbias("fob_guards", "cafe_enemies", 0);
  setthreatbias("cafe_enemies", "fob_guards", 0);
}

_id_71DD() {
  while(scripts\sp\utility::_id_77DD("fob_cafe_enemies") + scripts\sp\utility::_id_77DB("fob_cafe_enemy_bots") > 6)
    wait 0.1;

  wait 0.25;
  var_0 = getaiunittypearray("axis", "c6");

  foreach(var_2 in var_0) {
    var_2 _meth_81D0();
    wait 0.25;
  }

  thread scripts\sp\maps\moon_port\moon_port_util::_id_F293("fob_cafe_enemies", "fob_cafe_sdf_fallback", 0.1, 0.2, "frantic", 0.5);
  wait 1;
  thread scripts\sp\maps\moon_port\moon_port_util::_id_F293("fob_guards", "fob_cafe_mdf_pushup");

  while(scripts\sp\utility::_id_77DD("fob_cafe_enemies") + scripts\sp\utility::_id_77DB("fob_cafe_enemy_bots") != 0)
    wait 0.1;

  thread scripts\sp\maps\moon_port\moon_port_util::_id_F293("fob_guards", "fob_arrive_volume");
}

_id_71F8() {
  setthreatbias("fob_guards", "cafe_enemies_ledge", 0);
  setthreatbias("cafe_enemies_ledge", "fob_guards", 0);

  while(scripts\sp\utility::_id_77DD("fob_ledge_badguys") > 0)
    wait 0.1;

  scripts\sp\utility::_id_15F5("fob_ledge_moveup");
  thread _id_71DE();
}

_id_3B1B(var_0) {
  for(;;) {
    if(self istouching(var_0)) {
      scripts\sp\utility::_id_51E1("casual_gun");
      return;
    }

    wait 0.1;
  }
}

_id_71E6() {
  level endon("fob_halls_player_jumped_up");
  scripts\engine\utility::flag_wait("concourse_tigris_dialogue_finished");
  wait 1.0;
  scripts\engine\utility::flag_wait("concourse_curved_end_of_line");
  level.allies["eth3n"] scripts\sp\utility::_id_10346("moon_eth_lastterminalsco");
  level.allies["salter"] scripts\sp\utility::_id_10346("moon_slt_lastterminalscomingup");
  wait 0.5;
  scripts\sp\utility::_id_10350("moon_mdf1_sabretoblackhorse");
  wait 0.5;
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_mco_sabreweare");
}

_id_7202() {
  scripts\engine\utility::flag_wait("fob_halls_player_jumped_up");

  if(isDefined(level.allies["marine2"]) && isalive(level.allies["marine2"]))
    level.allies["marine2"] scripts\sp\utility::_id_10346("moon_un2_goteyeson");

  if(isDefined(level.allies["marine1"]) && isalive(level.allies["marine1"]))
    level.allies["marine1"] scripts\sp\utility::_id_10346("moon_eth_friendliesat9oc");

  level.allies["salter"] scripts\sp\utility::_id_10346("moon_slt_leftflankswideopen");
  scripts\sp\utility::_id_1034D("moon_plr_letstakeit");
  wait 0.5;
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_mco_spreadoutdonot");
}

_id_71EA() {
  level endon("fob_arrived");
  scripts\engine\utility::flag_wait("fob_halls_cafe_enemies_clear");
  wait 0.35;
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_mco_allclear");
  scripts\sp\utility::_id_1034D("moon_plr_nothreats");
  level.allies["eth3n"] scripts\sp\utility::_id_10346("moon_slt_secure");
  wait 0.5;
  level._id_71F7 scripts\sp\utility::_id_10346("moon_mdf2_appreciatethereinforcementwere");
  level.allies["salter"] scripts\sp\utility::_id_10346("moon_slt_thanksfortheupdate");
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_mco_terminalssecuregetyour");
  scripts\sp\utility::_id_1034D("moon_plr_coastguardyouhe");
  level._id_71F7 scripts\sp\utility::_id_10346("moon_mdf2_yessir");
}

_id_10669() {
  var_0 = getEntArray("fob_cafe_corpses_top", "targetname");

  foreach(var_2 in var_0)
  var_3 = var_2 scripts\sp\utility::_id_10619();

  wait 0.1;
}

_id_71EC(var_0) {
  var_1 = scripts\sp\utility::_id_77DA("fob_actor");

  foreach(var_3 in var_1) {
    if(isDefined(var_0) && var_0) {
      var_3 scripts\sp\utility::_id_51E1("casual_gun");
      continue;
    }

    var_3 scripts\engine\utility::delaythread(randomfloatrange(0.0, 0.45), scripts\sp\utility::_id_51E1, "casual_gun");
  }
}

_id_71E8() {
  thread _id_71E9();
}

_id_71E9() {}

_id_7203() {
  var_0 = ["marineCO", "salter", "eth3n", "marine1", "marine2"];
  scripts\sp\maps\moon_port\moon_port_util::_id_BC05("start_fob", var_0);
  wait 0.1;
  scripts\sp\utility::_id_15F3("fob_guard_spawn");
  wait 0.1;
  scripts\sp\utility::_id_15F3("fob_actor_spawn");
  wait 0.1;
  scripts\sp\maps\moon_port\moon_port_util::_id_BC53("start_fob");
  thread scripts\sp\maps\moon_port\moon_port_anim::_id_71FE();
  thread scripts\sp\maps\moon_port\moon_port_anim::_id_71FF();
  thread scripts\sp\maps\moon_port\moon_port_anim::_id_71F0();
  thread scripts\sp\maps\moon_port\moon_port_anim::_id_71F1();
  thread scripts\sp\maps\moon_port\moon_port_anim::_id_7205();
  thread scripts\sp\maps\moon_port\moon_port_anim::_id_7206();
  scripts\sp\utility::_id_28D7("allies");
  scripts\sp\utility::_id_28D7("axis");
  thread _id_10669();
  thread _id_71EC(1);
  level.player scripts\sp\utility::_id_F526("relaxed");

  foreach(var_2 in level.allies)
  var_2 scripts\sp\utility::_id_51E1("casual_gun");

  scripts\engine\utility::flag_set("fob_arrived");
}

_id_71F9() {
  scripts\engine\utility::flag_wait("fob_arrived");
  wait 2.0;
  scripts\sp\utility::_id_15F5("fob_halls_squad_door");
  thread _id_71E5();
  scripts\sp\maps\moon_port\moon_port_anim::_id_7201(level.allies["marineCO"]);
  scripts\engine\utility::flag_wait("fob_player_at_exit");
  scripts\engine\utility::flag_wait("fob_doors_open");
  level.player scripts\sp\utility::_id_F526("normal");
  thread _id_71E0();

  foreach(var_1 in level.allies)
  var_1 scripts\sp\utility::_id_4145();
}

_id_71E5() {
  scripts\engine\utility::flag_wait("flag_mco_at_fob_start");
  wait 20;
  thread _id_71FA();
  wait 1.0;
  scripts\engine\utility::flag_set("fob_doors_open");
}

_id_71FA(var_0) {
  wait 2;
  var_1 = getEnt("fob_exit_door_left", "targetname");
  var_2 = getEnt("fob_exit_door_right", "targetname");
  var_1 connectpaths();
  var_2 connectpaths();
  var_3 = var_1.origin;
  var_4 = var_2.origin;
  var_5 = scripts\engine\utility::getStruct(var_1.target, "targetname");
  var_6 = scripts\engine\utility::getStruct(var_2.target, "targetname");
  var_7 = 1.5;

  if(isDefined(var_0) && var_0)
    var_7 = 0.1;

  var_1 moveTo(var_5.origin, var_7);
  var_2 moveTo(var_6.origin, var_7);
  scripts\engine\utility::flag_wait("fob_cleanup_ambient_battle");
  var_1 moveTo(var_3, 0.1);
  var_2 moveTo(var_4, 0.1);
}

_id_71DC() {
  scripts\engine\utility::flag_wait("fob_cleanup_ambient_battle");
  scripts\sp\utility::_id_28D8("allies");
  scripts\sp\utility::_id_28D8("axis");
  var_0 = scripts\sp\utility::_id_77DA("fob_ambient_guys");

  foreach(var_2 in var_0)
  var_2 _meth_81D0();
}

_id_71DF() {
  thread _id_71E0();
}

_id_71E0() {
  scripts\sp\utility::_id_15F5("fob_guards_killspawner");
  scripts\engine\utility::flag_wait("fob_cleanup_ambient_battle");
  wait 1.0;
  var_0 = getEnt("fob_cafe_cleanup_vol", "targetname");
  var_1 = var_0 scripts\sp\utility::_id_77E3();

  foreach(var_3 in var_1) {
    if(scripts\engine\utility::array_contains(level.allies, var_3)) {
      continue;
    }
    if(isDefined(var_3._id_B14F) && var_3._id_B14F)
      var_3 scripts\sp\utility::_id_1101B();

    var_3 delete();
  }

  scripts\engine\utility::flag_wait("walkway_jackal_firing");
  scripts\sp\maps\moon_port\moon_port_util::_id_EA04("fob_exit_door_left");
  scripts\sp\maps\moon_port\moon_port_util::_id_EA04("fob_exit_door_right");
  scripts\sp\maps\moon_port\moon_port_util::_id_EA04("fob_wounded_1");
  scripts\sp\maps\moon_port\moon_port_util::_id_EA04("fob_wounded_2");
  scripts\sp\maps\moon_port\moon_port_util::_id_EA04("fob_typer_1_node");
  scripts\sp\maps\moon_port\moon_port_util::_id_EA04("fob_typer_2_node");
  scripts\sp\maps\moon_port\moon_port_util::_id_EA04("fob_help_1_a_hit");
  scripts\sp\maps\moon_port\moon_port_util::_id_EA04("fob_help_1_b");
  scripts\sp\maps\moon_port\moon_port_util::_id_EA04("fob_help_1_a");
  scripts\sp\maps\moon_port\moon_port_util::_id_EA04("fob_help_2_b");
  scripts\sp\maps\moon_port\moon_port_util::_id_EA04("fob_help_2_a");
  scripts\sp\maps\moon_port\moon_port_util::_id_EA04("fob_arrive_volume");
}