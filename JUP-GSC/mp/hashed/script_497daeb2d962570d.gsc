/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_497daeb2d962570d.gsc
*************************************************/

#using script_1107d6250762b72b;
#using script_2047cdbf5176ba0;
#using script_2816a042b9f7996;
#using script_2a73cf62256b4021;
#using script_5d813d45c6b1b1be;
#using script_624397dc74b139e0;
#using script_62a4f7a62643fe8;
#using script_69a720c9d6e76eaf;
#using script_7cb35f89ed0ca240;
#using script_7cfaa6fd841fb4dd;
#using script_92b815b18f0ba61;
#using script_a462ba1c690f492;
#using scripts\common\callbacks;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\engine\utility;
#namespace mp_jup_st_e_ob;

function autoexec init() {
  level.var_d6d4a817542a6b12 = &main;
}

function main() {
  function_eb7f544259415a09("mp_jup_bigmap_ob");
  function_3c4620aaf1b2a314();
  level thread namespace_e39de371869cd948::function_9a77b5ad8fe80b87();
  namespace_46bab6a1c7f2b759::main();
  namespace_168ecff99ee1ba99::main();
  scripts\engine\utility::flag_set("gas_station_create_script_initialized");
  namespace_900b5c2f06237e4c::main();
  thread namespace_6776e8e74ed64842::init();

  if(getdvarint(@ "hash_ce91a4697b7f675d", 0)) {
    thread function_34f9339be7842373();
    thread director_changes();
  } else {
    thread function_5e1d3784c9aa680f();
    level callback::add("register_activities", &function_98dce343b7f26b31);
    level callback::add("register_objectives", &function_ecac14e0ca8cf16);
    level callback::add("register_features", &function_78d897de4d1793f);
  }

  setDvar(@ "hash_f1d095735ac37f33", 1);
  thread function_9e62f0bf427c88b2();
  namespace_eaf2d79326b082fa::main();
  var_21af86bdbe252abf = getStructArray("vehicle_group_e", "script_noteworthy");
  level thread namespace_f9b6a4254d2d8100::function_63c6d4fbc0bc4d94(var_21af86bdbe252abf);

  if(getDvar(@ "hash_6e5464e5ee3bd77d", "0") == "1") {
    namespace_7505bd48eaef63fb::main();
    thread namespace_d0c78bdaf71b04f6::init();
  }
}

function function_34f9339be7842373() {
  waitframe();
  function_9b8829ab4092a7d7("ob_soldier_ambient", 1);
  scripts\cp_mp\agents\ai_spawn_director::function_e4a440552e4cf1f4(&function_7a74948bde86f65);
  function_4ff17efd15d01d3f(256);
  function_1611d0f6b5f84b9a(700);
  var_6019f08417208580 = ["c_sabotage_lowtown_park_1", "c_sabotage_lowtown_park_1", "c_sabotage_lowtown_park_1", "c_sabotage_lowtown_park_1", "c_sabotage_lowtown_park_1", "e_cover_merc_camp_lowtown_market", "e_cover_merc_camp_lowtown_riverfront", "e_cover_merc_camp_lowtown_shanty"];

  foreach(str in var_6019f08417208580) {
    namespace_64135de19550f047::function_e9158c9e8c391f25(str);
  }
}

function private function_7a74948bde86f65(agent, requestid, data) {
  if(!isDefined(data.script_stealthgroup)) {
    data.script_stealthgroup = "sgp_" + requestid;
  }

  agent thread function_26ee393ba852c090();
}

function private function_26ee393ba852c090() {
  self endon("death");

  while(true) {
    while(!isDefined(self.enemy)) {
      wait 0.1;
    }

    if(getdvarint(@ "hash_479f55fba6e8526b", 0)) {
      while(isDefined(self.enemy)) {
        mintime = getdvarfloat(@ "hash_83cb4d26f93ea87e", 9);
        maxtime = getdvarfloat(@ "hash_8e181885f3741094", 15);
        movetime = randomfloatrange(mintime, maxtime);
        wait movetime;
        newspot = getrandomnavpoint(self.origin, 500);

        if(isDefined(newspot)) {
          self setgoalpos(newspot, 64);
          self waittill("goal");
        }
      }
    }

    waitframe();
  }
}

function director_changes() {
  waitframe();
  scripts\cp_mp\agents\ai_spawn_director::director_init();
  request_id = scripts\cp_mp\agents\ai_spawn_director::function_930897c0d1a7eb24("demo_gas_encounter");
  function_fc38783a3da0bc71(request_id, 1);
  waitframe();
  function_606642b946a01237("demo1", (17896.5, -9628.5, 2067.5), 800, 1);
  function_606642b946a01237("demo2", (17722.5, -11636.5, 2067.5), 1200, 1);
  function_606642b946a01237("demo3", (16652.5, -9595.5, 2067.5), 500, 1);
}

function function_9e62f0bf427c88b2() {
  function_678622c552cadad4();
  scripts\cp_mp\agents\ai_spawn_director::process_create_script();
}

function function_678622c552cadad4() {
  flag_wait("mp_jup_st_e_ob_objective_mercdefend_cs_completed");
}

function function_5e1d3784c9aa680f() {
  waitframe();

  if(getdvarint(@ "ob_test_abomination", 0)) {
    function_9b8829ab4092a7d7("ob_test_abomination", 1);
  }

  function_9b8829ab4092a7d7("ob_zombie_ambient", 1);
  a_pos = scripts\engine\utility::getStructArray("s_ob_overpass_supress", "targetname");

  foreach(pos in a_pos) {
    function_606642b946a01237("overpass_supress", pos.origin, pos.radius, 1);
  }

  var_102014ab68ac4b78 = scripts\engine\utility::getStructArray("s_ob_infil_supress", "targetname");

  foreach(pos in var_102014ab68ac4b78) {
    function_606642b946a01237("infil_supress", pos.origin, pos.radius, 1);
  }

  var_102015ab68ac4dab = scripts\engine\utility::getStructArray("s_ambient_blocker", "targetname");

  foreach(pos in var_102015ab68ac4dab) {
    if(isDefined(pos.radius)) {
      function_606642b946a01237("ambient_blocker", pos.origin, pos.radius, 1);
    }
  }
}