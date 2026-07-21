/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_donetsk\cp_donetsk_obj_helidown.gsc
**********************************************************/

heli_down_precache() {
  level._effect["_encstr_8A260BB958DDEB6E38854EB6CD"] = loadfx("_encstr_8E24329D99F079D2BB83F51BC1BC36599DACB15E1B83D7C439BEB95E936D79ECCC1EBE6C07AFCDB077BEDC83B093B5E6B83B663C");
  level._effect["_encstr_B8DC10183F8D7457BF7738A11271B8E0B44D"] = loadfx("_encstr_B1473108DAA09FE817E8786E984E91D9CD23B06873AD954143E77ED36FDB3B9BF279A080CBD9FB5ABBCC705671FFA0C55B92E0");
  level._effect["_encstr_99B91250F35864D3F0A3B2A9EBDFDF9DA073C2A5"] = loadfx("_encstr_88362ED39980C0D07742512BC9CEB9C46843D8D7B52E2EF3DAC7475BA1FF9933C05196540A60F6A1934801CC5A4575D0");
  level._effect["_encstr_9ADE10A1DDE97BD87AAC08A9DF60E0A39407"] = loadfx("_encstr_925B2A5333C1E58FCB0347733F187FFC0748BBFA08D7EBFB4298437840BB7BC6653873D12005655BB0744E78");
  level._effect["_encstr_B2251330933804F3D083928969B627FBC009B59811"] = loadfx("_encstr_9AB231FCAE2B28030B5F19F0F335CF189F4007FD12CE4B55B031C070F9FE91B0BBE805EEA78773BFDB4AF001725099600B6613");
  level._effect["_encstr_9A240FD02BC6968CDBEEE6D738D8EAB5CA"] = loadfx("_encstr_858C29C39FAB2F87A83A9673C26E6AD247F729B9EA6FACDB60E946BC48F3ABE9F2BF9848875A77B6C6F738");
  level._id_13661 = ::spawnhelihvtexfilactors;
  thread update_crash_locations();
}

update_crash_locations() {
  wait 5;
  level.vehicle.helicopter_crash_locations = scripts\engine\utility::array_combine(level.vehicle.helicopter_crash_locations, scripts\engine\utility::getstructarray_delete("_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
  register_spawn_groups();
}

register_helidown_objective() {
  scripts\cp\cp_objectives::registerobjective("_encstr_93A00D27E86A607C5BB4B392C053BB", ::emptyfunc, ::helidown_start_func, ::emptyfunc, undefined, ::helidown_start_func_debug);
  scripts\cp\cp_objectives::registerobjective("_encstr_8A4318187658771A4D4CF8B0752F3367FFE696DF7BEBF669BB1B", ::emptyfunc, ::helidown_escort_start_func, ::emptyfunc, undefined, ::helidown_start_func_debug);
  level thread wait_for_players_near_obj();
  level thread wait_for_escort_start();
}

begin_wave_spawning() {
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
  wait 15;
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
}

wait_for_escort_start() {
  while(!isDefined(level.mission_select))
    wait 1;

  scripts\engine\utility::flag_init("_encstr_B2C91633331E824859A355C9D204D8ACF0518507F35DEB60");
  scripts\engine\utility::flag_wait("_encstr_B2C91633331E824859A355C9D204D8ACF0518507F35DEB60");
  level.event_active = 1;
  level thread helidown_escort_start_func();
  scripts\engine\utility::flag_wait("_encstr_8EF22A05863066E3A830B29CC07364B123383F8C35A23AC6A1FD178E4746A06F42D3E1E6A85370113AABD86C");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
  level.event_active = 0;
}

wait_for_players_near_obj() {
  while(!isDefined(level.mission_select))
    wait 1;

  scripts\engine\utility::flag_init("_encstr_83430FAA94AB1BA3FEC1F7F884A46D9FA0");
  scripts\engine\utility::flag_wait("_encstr_83430FAA94AB1BA3FEC1F7F884A46D9FA0");

  for(;;) {
    if(istrue(level.event_active)) {
      wait 1;
      continue;
    }

    level.event_active = 1;
    level thread helidown_start_func();
    scripts\engine\utility::flag_wait("_encstr_8EF22A05863066E3A830B29CC07364B123383F8C35A23AC6A1FD178E4746A06F42D3E1E6A85370113AABD86C");
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
    level.event_active = 0;
    return;
  }
}

emptyfunc(var_0) {}

helidown_start_func_debug(var_0) {
  setDvar("_encstr_910F0FE1553560159F6BD8E652235D90CB", "_encstr_BEBA0860360273C54B4F");
}

helidown_start_func(var_0) {
  level notify("_encstr_820E0E4A64C00D6B7F02A3D93BE03152");
  setDvar("_encstr_910F0FE1553560159F6BD8E652235D90CB", "_encstr_BEBA0860360273C54B4F");
  wait 5;
  level thread begin_wave_spawning();
  scripts\cp\cp_objectives_events::try_start_event("_encstr_84FD1A1FB5202FF745A8EBC2769327A580678C97E768F98F6D41A3DB", "_encstr_880C3C3BB35631C950FFEF1ED84E55AE898282F758FFAC08F2E9603BCA081BD9B823C8F505CBE08A390FDE0A57A92BF0436848F73594D5505C5BE6DAFFF3", 1);
}

helidown_escort_start_func(var_0) {
  setDvar("_encstr_910F0FE1553560159F6BD8E652235D90CB", "_encstr_8C440795DC8DED271D");
  setDvar("_encstr_960C13231028E0114F48A397621E1C7078B9D99F60", "_encstr_A34C02BB");
  wait 5;
  level thread begin_wave_spawning();
  scripts\cp\cp_objectives_events::try_start_event("_encstr_84FD1A1FB5202FF745A8EBC2769327A580678C97E768F98F6D41A3DB", "_encstr_880C3C3BB35631C950FFEF1ED84E55AE898282F758FFAC08F2E9603BCA081BD9B823C8F505CBE08A390FDE0A57A92BF0436848F73594D5505C5BE6DAFFF3", 1);
}

heli_down_init(var_0) {
  if(!scripts\engine\utility::flag_exist("_encstr_973C1C6D3CA9BBE347B0BA22906FDF0743A8F5E4C031F76DC168A29BE861"))
    scripts\engine\utility::flag_init("_encstr_973C1C6D3CA9BBE347B0BA22906FDF0743A8F5E4C031F76DC168A29BE861");

  scripts\engine\utility::flag_clear("_encstr_973C1C6D3CA9BBE347B0BA22906FDF0743A8F5E4C031F76DC168A29BE861");
  level thread main(var_0);
}

objective_heli_down_start(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = 0;
  var_2 = var_0.showobjprogress * -1;

  if(getdvarint("_encstr_A91E19180FF296B31337506581CA8BB8418B70405387AB616A1A55", 0) == 1) {
    var_0.showobjprogress = 30;
    var_2 = 30;
  }

  objective_setownerteam(var_0.objectiveindex, "_encstr_9A8507BA4040188D08");

  while(var_1 <= var_2) {
    wait 0.25;
    var_1 = var_1 + 0.25;
  }

  level notify("_encstr_A1F2171A2BB19691F6EE9BAF3AA56B5639F55987E05AC995C8");

  while(istrue(level.helidown_event_active))
    wait 0.1;

  wait 0.5;
  scripts\cp\cp_objectives_events::mark_event_completed("_encstr_84FD1A1FB5202FF745A8EBC2769327A580678C97E768F98F6D41A3DB");
  scripts\cp\cp_objectives_events::delete_old_objective_location("_encstr_93501495C777607BAF4940801205011E8F78A89625EB");
  scripts\cp\cp_objectives_events::stop_event("_encstr_84FD1A1FB5202FF745A8EBC2769327A580678C97E768F98F6D41A3DB");
  scripts\cp\cp_objectives_events::disable_repeating_event("_encstr_84FD1A1FB5202FF745A8EBC2769327A580678C97E768F98F6D41A3DB");
}

main(var_0) {
  if(getdvarint("_encstr_93670CB2370B313659D7C1CE38CA") == 1)
    level thread exfil_players_on_rescue_fail();

  level endon("_encstr_8DB01DF631A6AC6CD12DCEB2FA34591B2DBE91BDEE9BFAB6B41B8DBE86EC8E");
  setdvarifuninitialized("_encstr_AA67150B8020D9F267045D19E323CB96A988EF4F20B80B", "_encstr_A14C023B");
  setdvarifuninitialized("_encstr_B2E014435663D28CEDEEB9BE95B9B1F693477DB1ED8D", "_encstr_A14C023B");
  setdvarifuninitialized("_encstr_960C13231028E0114F48A397621E1C7078B9D99F60", "_encstr_A34C02BB");
  setdvarifuninitialized("_encstr_910F0FE1553560159F6BD8E652235D90CB", "_encstr_BEBA0860360273C54B4F");
  var_1 = ["_encstr_BEBA0860360273C54B4F", "_encstr_8C440795DC8DED271D"];
  var_2 = scripts\engine\utility::random(var_1);

  if(getDvar("_encstr_910F0FE1553560159F6BD8E652235D90CB") != "_encstr_B40101")
    var_2 = getDvar("_encstr_910F0FE1553560159F6BD8E652235D90CB");

  if(var_2 == "_encstr_8C440795DC8DED271D")
    scripts\cp\cp_modular_spawning::increase_reserved_spawn_slots(1, "_encstr_92DF0A13BAFB2E53D7214BE3");

  level.event_heli_type = var_2;
  var_3 = spawn_helidown_heli(var_0);
  var_3 shoot_down_heli(var_0);
  var_3.death_fx_on_self = 1;
  var_4 = undefined;

  if(var_2 == "_encstr_8C440795DC8DED271D") {
    var_4 = scripts\cp\cp_vip::vip_spawn(var_3, 0, "_encstr_92DF0A13BAFB2E53D7214BE3");
    scripts\cp\cp_modular_spawning::decrease_reserved_spawn_slots(1, "_encstr_92DF0A13BAFB2E53D7214BE3");
    var_4.script_noteworthy = "_encstr_BEF6186B7BF29008EFAC11489487C0588BB3D3E1474BEB10E783";
    var_4.nodamage = 1;
    thread vip_parachute(var_4, var_3, var_0);
  }

  var_5 = var_3.vehicle_spawner.script_noteworthy;
  var_6 = heli_crash(var_3, var_0, var_2);
  var_6.location = var_5;
  init_cutout_anims();

  switch (var_2) {
    case "_encstr_BEBA0860360273C54B4F":
      var_6 thread heli_corpse_burn();
      rescue_type_harness(var_6, var_0);
      break;
    case "_encstr_8C440795DC8DED271D":
      rescue_type_escort(var_6, var_0, var_4);
      break;
  }

  level.helidown_event_active = 0;
  scripts\cp\cp_objectives_events::mark_event_completed("_encstr_84FD1A1FB5202FF745A8EBC2769327A580678C97E768F98F6D41A3DB");
  scripts\cp\cp_objectives_events::stop_event("_encstr_84FD1A1FB5202FF745A8EBC2769327A580678C97E768F98F6D41A3DB");
  scripts\cp\cp_objectives_events::disable_repeating_event("_encstr_84FD1A1FB5202FF745A8EBC2769327A580678C97E768F98F6D41A3DB");
  scripts\cp\cp_objectives_events::delete_old_objective_location("_encstr_93501495C777607BAF4940801205011E8F78A89625EB");
  level notify("_encstr_9AD60EF02518379757389A8148BFCDDF");
}

heli_corpse_burn() {
  self setscriptablepartstate("_encstr_B26D075A0B88E72AEF", "_encstr_AB0703DBB9");
  wait 100;
  self setscriptablepartstate("_encstr_B26D075A0B88E72AEF", "_encstr_BA19049F4B2D");
  self setscriptablepartstate("_encstr_856D07E6D10BD9CA64", "_encstr_AB0703DBB9");
  wait 100;
  self setscriptablepartstate("_encstr_856D07E6D10BD9CA64", "_encstr_BA19049F4B2D");
  self setscriptablepartstate("_encstr_8A6D07B9E816CE9566", "_encstr_AB0703DBB9");
  wait 100;
  remove_heli_corpse_after_timeout(1);
}

rescue_type_harness(var_0, var_1) {
  var_1.label = &"_encstr_AC7A2769332F25CD918AFB6694C9AF6D521FE149FF9E1D077EA57E62F93173B783F7A99903697447F1";
  var_2 = spawn_downed_pilot(var_0, var_1);
  var_2 endon("_encstr_AD75063D571AE108");
  var_2 endon("_encstr_992C09B5C322C558EFDB03");
  level.helidown_downed_pilot = var_2;
  var_2 thread downed_pilot_dialogue();
  pilot_wait_for_rescue(var_1, var_2, var_0);
  create_long_cut_interactions(var_0, var_2, var_1);
  wait_for_door_cut_long(var_1, var_2);
  remove_pilot_from_cockpit(var_0, var_1, var_2);
  enable_pilot_carry(var_2);
  exfil_pilot(var_2, var_1, var_0);
}

rescue_type_escort(var_0, var_1, var_2) {
  var_2 waittill("_encstr_95DF070DD22319CA9B");
  var_0 thread remove_heli_corpse_after_timeout(0, 5);
  var_2 thread escort_vip_to_chopper(var_2, var_0, var_1);
  var_3 = var_2 scripts\engine\utility::_id_143B4("_encstr_AD75063D571AE108", "_encstr_8A12060D5BA9C745");

  if(var_3 == "_encstr_AD75063D571AE108") {
    var_1 notify("_encstr_9369093BB483AF325A5991");
    scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_930A26B178A16857A791B09B8A3F0E2BC273EB3BBFD2F0912F3B8EE1928F4E4011CE4BBB24F18AC7", "_encstr_9A8507BA4040188D08");
  } else
    scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_9A6D28F4B366079A6781820B63E7D2D75B966D6D58EB77A5773089F238E54B33F210C5F86C10AB21B32A", "_encstr_9A8507BA4040188D08");
}

vip_parachute(var_0, var_1, var_2) {
  vip_spawn_parachute(var_1, var_0);
  vip_parachute_nearby(var_1, var_0);
  vip_update_objective_on_landed(var_0, var_1, var_2);
  var_0 setCanDamage(0);
  var_0.ignoreme = 1;
  var_0.ignoreall = 1;
  vip_go_and_hide(var_0, var_2);
}

vip_spawn_parachute(var_0, var_1) {
  var_1.chute = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_1.chute.angles = var_0.angles;
  var_1.chute setModel("_encstr_B483150653B887D37F2D4737611DDBF5797B7D0E6A1852");
  var_1 allowedstances("_encstr_A5AD069B231F0BAF");
  var_1 linkTo(var_1.chute, "_encstr_8E010B996FB7B6B3C1D1183343", (0, 0, 0), (0, 0, 0));
  var_1.chute scriptmodelplayanim("_encstr_887C16CD32E47D6B38FA0E162785C6A1AB47ACFAB49163B2");
  var_2 = var_1 scripts\asm\asm::asm_lookupanimfromalias("_encstr_84610D49100897C2DF809A03583BFF", "_encstr_92F20FC185E42C8D43ABD1B2FA4B1936B2");
  var_3 = var_1 scripts\asm\asm::asm_getxanim("_encstr_84610D49100897C2DF809A03583BFF", var_2);
}

vip_parachute_nearby(var_0, var_1) {
  var_2 = scripts\engine\utility::get_array_of_closest(var_0.origin, scripts\engine\utility::getStructArray("_encstr_9A2709EC4B07F58D58CD46", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"), undefined, 2, 10000);
  var_3 = scripts\engine\utility::random(var_2);

  if(getDvar("_encstr_B2E014435663D28CEDEEB9BE95B9B1F693477DB1ED8D", "_encstr_B40101") != "_encstr_B40101") {
    var_4 = getDvar("_encstr_B2E014435663D28CEDEEB9BE95B9B1F693477DB1ED8D");

    foreach(var_6 in var_2) {
      if(isDefined(var_6.script_noteworthy) && var_6.script_noteworthy == "_encstr_A2D30CE7060732BA43296B5FF01E" + var_4) {
        var_3 = var_6;
        break;
      }
    }
  }

  var_1.landing_spot = var_3;
  level thread proximity_spawn(var_1.landing_spot, var_1.landing_spot.script_noteworthy);
  var_1.chute moveTo(var_3.origin + (0, 0, 350), 12, 1, 1);
  var_1.chute waittill("_encstr_9B420907FD535DAC6DF285");
  var_1 unlink();
  var_1 forceteleport(var_3.origin, var_3.angles);
  var_1.chute delete();
  return var_3;
}

vip_update_objective_on_landed(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_2.objicon = "_encstr_A53D11426BF5B794C8078EB71FF09AABABE04A";
  var_2.label = &"_encstr_B27F231A41BE2449AF4D2B4AD2AFA7249251D01592B2A89A5EC4A734828A2AF50525987AA8";
  var_3.targetname = "_encstr_93501495C777607BAF4940801205011E8F78A89625EB";
  var_4 = scripts\engine\utility::getStructArray(var_0.landing_spot.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_6 in var_4) {
    if(!isDefined(var_6.script_noteworthy)) {
      continue;
    }
    if(var_6.script_noteworthy == "_encstr_A69C0877C6C2CF95B79F")
      var_3.origin = var_6.origin + (0, 0, 65);
  }

  scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_8C55288C0FD71BC1CDFAF69D1BEB272BE6D8D5CAF5E0A5D8DB3AAFCAD4566C1DD7D5C119584795F51381", "_encstr_9A8507BA4040188D08");
  scripts\cp\utility::addtostructarray("_encstr_B2CE0BA1D0FB19FDC54613D9BF", "_encstr_93501495C777607BAF4940801205011E8F78A89625EB", var_3);
  var_0 thread complete_killer(undefined, var_2);
  scripts\engine\utility::flag_set("_encstr_973C1C6D3CA9BBE347B0BA22906FDF0743A8F5E4C031F76DC168A29BE861");
}

vip_go_and_hide(var_0, var_1) {
  scripts\cp\cp_vip::create_vip_trigger(var_0);
  var_2 = [];
  var_3 = scripts\engine\utility::getStructArray(var_0.landing_spot.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_5 in var_3) {
    if(!isDefined(var_5.script_noteworthy) || var_5.script_noteworthy != "_encstr_A69C0877C6C2CF95B79F")
      var_2[var_2.size] = var_5;
  }

  var_7 = scripts\engine\utility::random(var_2);

  if(getdvarint("_encstr_AF0E183EEB436641CF5AE8884263153E4399CDBB4EAF2BB9B5C3", -1) > -1) {
    foreach(var_9 in var_2) {
      if(isDefined(var_9.location) && int(var_9.location) == getdvarint("_encstr_AF0E183EEB436641CF5AE8884263153E4399CDBB4EAF2BB9B5C3")) {
        var_7 = var_9;
        break;
      }
    }
  }

  if(getdvarint("_encstr_A9A71AB678AFFBA7047248787A9DBF90171033A5C1032107EAFA80A0") > 0)
    var_0 thread debug_hiding_spots(var_2, var_7);

  var_0 thread show_vip_waypoints(var_2);
  var_11 = getclosestpointonnavmesh(var_7.origin);
  var_0.goalradius = 32;
  var_0 setgoalpos(var_7.origin);
  var_0 waittill("_encstr_8B7205D9ED5958");
  wait 1;

  if(!isDefined(var_7.angles))
    var_7.angles = (0, 0, 0);

  var_12 = anglesToForward(var_7.angles) * 15;
  var_13 = spawn_pilot_attacker(var_11, var_7.angles);
  var_13 scripts\cp\cp_skits::setup_fight_guy();
  var_0 scripts\cp\cp_skits::setup_fight_guy();
  var_0 forceteleport(var_11 + var_12, var_7.angles);
  var_0.anchor = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_11 + var_12);
  var_0.anchor.angles = var_7.angles;
  var_0 linkTo(var_0.anchor);
  var_13.anchor = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_11);
  var_13.anchor.angles = var_7.angles;
  var_13 linkTo(var_13.anchor);
  var_0.attacker = var_13;
  thread scripts\cp\cp_skits::hostage_rescue_meatshield(undefined, undefined, undefined, undefined, var_13, var_0, 300);
  var_0 notify("_encstr_95DF070DD22319CA9B");
}

spawn_pilot_attacker(var_0, var_1) {
  scripts\cp\cp_modular_spawning::increase_reserved_spawn_slots(1, "_encstr_92DF0A13BAFB2E53D7214BE3");

  for(;;) {
    if(scripts\cp\cp_modular_spawning::allowed_to_spawn_agent(undefined, 1, 1, "_encstr_B4E2074C0BC83B57BC")) {
      var_2 = scripts\mp\mp_agent::spawnnewagentaitype("_encstr_B801227E96C1DA42DE10FBDF38723742612002F3066FA29D6308F38391EBC84A31444BAD", var_0, var_1);

      if(isDefined(var_2)) {
        var_2 scripts\cp\cp_modular_spawning::update_spawn_data_on_spawn();
        var_2 thread scripts\cp\cp_modular_spawning::_update_spawn_data_on_death();
        break;
      }
    }

    wait 0.1;
  }

  scripts\cp\cp_modular_spawning::decrease_reserved_spawn_slots(1, "_encstr_92DF0A13BAFB2E53D7214BE3");
  var_2.scripted_mode = 1;
  var_2.ignoreall = 1;
  var_2.dontkilloff = 1;
  var_2.health = 25;
  var_2.maxhealth = 25;
  var_2.suppressionthreshold = 0.0;
  return var_2;
}

debug_hiding_spots(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B1DA09D3DB3FF1756059F7");

  for(;;) {
    foreach(var_3 in var_0) {
      if(var_3 == var_1)
        continue;
    }

    wait 0.5;
  }
}

spawn_helidown_heli(var_0) {
  var_1 = get_heli_spawn_struct();
  var_2 = spawn_objective_heli(var_1);
  var_2 thread scripts\common\vehicle_paths::vehicle_paths_helicopter(scripts\engine\utility::getclosest(var_2.origin, scripts\engine\utility::getStructArray("_encstr_85FA0F591782ACB7A3C838882911893C80", "_encstr_B2CE0BA1D0FB19FDC54613D9BF")));
  var_2 playLoopSound("_encstr_95A3252F204ECA8B0F0EE05A7A67D2981088DBBFA8A60592472B2D9748C9EA56FBD0EF23989B6C");
  level thread scripts\common\vehicle_paths::gopath(var_2);
  return var_2;
}

get_heli_spawn_struct() {
  if(!isDefined(level.heli_down_structs))
    level.heli_down_structs = scripts\engine\utility::getStructArray("_encstr_BAB30E63D388D4F4584435B1E8D07BA3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(;;) {
    var_0 = scripts\engine\utility::random(level.heli_down_structs);

    if(!isDefined(level.last_helidown_loc) || var_0 != level.last_helidown_loc) {
      break;
    }

    wait 0.05;
  }

  level.heli_down_structs = scripts\engine\utility::array_remove(level.heli_down_structs, var_0);

  if(level.heli_down_structs.size == 0)
    level.heli_down_structs = scripts\engine\utility::getStructArray("_encstr_BAB30E63D388D4F4584435B1E8D07BA3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(getdvarint("_encstr_AA67150B8020D9F267045D19E323CB96A988EF4F20B80B") > 0) {
    var_1 = getdvarint("_encstr_AA67150B8020D9F267045D19E323CB96A988EF4F20B80B");
    var_2 = scripts\engine\utility::getStructArray("_encstr_BAB30E63D388D4F4584435B1E8D07BA3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_4 in var_2) {
      if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == "_encstr_86AD05B1F6B1FA" + var_1)
        return var_4;
    }
  }

  level.last_helidown_loc = var_0;
  return var_0;
}

spawn_objective_heli(var_0) {
  var_1 = scripts\common\vehicle::vehicle_spawn(var_0);
  var_1.vehicle_skipdeathmodel = 1;
  var_1.death_fx_on_self = 1;
  return var_1;
}

shoot_down_heli(var_0, var_1) {
  self waittill("_encstr_BD5F0BFB38CB2D3B8F6E437CD3");
  var_2 = anglestoleft(self.angles);
  var_3 = getgroundposition(self.origin, 16);
  var_4 = magicbullet("_encstr_8DB918C25BED5F06B857948ADF784F5F99107B6B40490771A031", var_3, self.origin);
  var_4 missile_settargetEnt(self);
  var_4 missile_setflightmodedirect();
  target_hit_monitor(var_4, self);
}

target_hit_monitor(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_5 = var_1.origin - var_0.origin;

  for(;;) {
    if(missile_hit_target(var_0, var_1, var_5)) {
      break;
    }

    waitframe();
  }

  playFX(level._effect["_encstr_B8DC10183F8D7457BF7738A11271B8E0B44D"], var_0.origin);
  playFX(level._effect["_encstr_9ADE10A1DDE97BD87AAC08A9DF60E0A39407"], var_1.origin);
  var_0 detonate();
}

missile_hit_target(var_0, var_1, var_2) {
  if(distancesquared(var_0.origin, var_1.origin) <= 90000)
    return 1;

  var_3 = var_1.origin - var_0.origin;

  if(vectordot(var_2, var_3) < 0)
    return 1;

  return 0;
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");

heli_crash(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getclosest(var_0.origin, level.vehicle.helicopter_crash_locations);

  if(isDefined(var_0.perferred_crash_location))
    var_3 = var_0.perferred_crash_location;

  if(isDefined(var_2) && var_2 == "_encstr_BEBA0860360273C54B4F")
    level thread proximity_spawn(var_3.origin, var_3.script_noteworthy);

  var_4 = undefined;

  if(isDefined(var_2)) {
    var_4 = scripts\cp\cp_objectives::requestworldid("_encstr_854711C86BC0FC2718BBFB9283782FF2F0E776", 10);
    objective_icon(var_4, "_encstr_A53D11426BF5B794C8078EB71FF09AABABE04A");
    objective_setminimapiconsize(var_4, "_encstr_8A9C0D3F5F2072CF1829A72BE0682A");
    objective_setshowdistance(var_4, 1);
    objective_onentity(var_4, var_0);
    objective_setbackground(var_4, 1);
    objective_setlabel(var_4, &"_encstr_A9EA24DEAF59B51AEF7AAB95E3EF713E4465132FBB6D0FAB705150C88CF118BC69D19B18FAD7");
    objective_state(var_4, "_encstr_AF5A081BBAC993AC73A3");
    objective_setplayintro(var_4, 0);
    objective_setownerteam(var_4, "_encstr_9A8507BA4040188D08");
  }

  if(!isDefined(var_3.angles))
    var_3.angles = (0, 0, 0);

  level.vehicle.templates.vehicle_death_fx["_encstr_AA6F1AFF6F7308C395309EDDD0630AC369B19A8B721F128AAAC95B67"][0].effect = level._effect["_encstr_99B91250F35864D3F0A3B2A9EBDFDF9DA073C2A5"];
  var_0 playSound("_encstr_869A222EFB0992CB48073F1B1F1082C0E083623713B14AD2BE2F771B0F25FB1020C81FBF");
  var_0 stoploopsound("_encstr_95A3252F204ECA8B0F0EE05A7A67D2981088DBBFA8A60592472B2D9748C9EA56FBD0EF23989B6C");
  var_0 notify("_encstr_AD75063D571AE108", level.players[0], "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", undefined, var_0.origin);
  level notify("_encstr_A3AC0E689D58D2870256B720A28B8AA7", var_0);
  var_0 playLoopSound("_encstr_A6A01E7BCFF7F21277DFCB63578001742013EB8A9BD1A7CBCF48598EA0F038CB");
  var_0 waittill("_encstr_A5D616CECAD0D28DC656F5C89516471A1A7B5BC1D895E8CA", var_5, var_6);
  var_0 delete();
  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3.origin);
  var_7.angles = var_3.angles;
  var_7 setModel("_encstr_AAB020634BD75F99C33D81391F6D60296F12D8AB21471B0851128193455609E577DB");
  var_8 = anglesToForward(var_3.angles);
  var_9 = anglestoleft(var_3.angles);
  var_7.navobs = createnavobstaclebybounds(var_7.origin + var_8 * -175 + var_9 * 25, (375, 50, 150), var_7.angles);
  var_7.navobs2 = createnavobstaclebybounds(var_7.origin + var_8 * -425 + var_9 * 150, (150, 50, 150), var_7.angles);
  var_7.clipmodel = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_7.origin);
  var_7.clipmodel clonebrushmodeltoscriptmodel(getEnt("_encstr_B6EE0E2209910FB7C857AE9717B8BC33", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
  var_7.clipmodel.angles = var_7.angles;
  var_7 useanimtree(#animtree);
  var_7 scriptmodelplayanim("_encstr_B16833F78333B81B50F120D8E23C58EC3A07694B270A7560A796A8100D11A815F333E5FFA732B551B9EF90E9B9FAA05BCACFB14F0B");

  if(isDefined(var_3.script_noteworthy))
    var_7.script_noteworthy = var_3.script_noteworthy;

  if(isDefined(var_4)) {
    objective_delete(var_4);
    scripts\cp\cp_objectives::freeworldid("_encstr_854711C86BC0FC2718BBFB9283782FF2F0E776");
  }

  var_7 setscriptablepartstate("_encstr_878807108A42A309BB", "_encstr_AB0703DBB9");
  radiusdamage(var_7.origin + (0, 0, 50), 750, 1000, 50);
  return var_7;
}

spawn_downed_pilot(var_0, var_1) {
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_2.body = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
  var_2.body setModel("_encstr_951317DEBA8CD42FCFFCF7DAA7FB85D3B85F4BB88AA8984F30");
  var_2.bodymodel = "_encstr_951317DEBA8CD42FCFFCF7DAA7FB85D3B85F4BB88AA8984F30";
  var_2.body.animname = "_encstr_B1190448CD80";
  var_2.body useanimtree(level.scr_animtree["_encstr_B1190448CD80"]);
  var_2.script_noteworthy = "_encstr_BEF6186B7BF29008EFAC11489487C0588BB3D3E1474BEB10E783";
  var_0 thread idle_pilot_loop(var_2);
  var_3 = spawnStruct();
  var_3.targetname = "_encstr_93501495C777607BAF4940801205011E8F78A89625EB";
  var_3.origin = var_2.origin + (0, 0, 25);
  scripts\cp\utility::addtostructarray("_encstr_B2CE0BA1D0FB19FDC54613D9BF", "_encstr_93501495C777607BAF4940801205011E8F78A89625EB", var_3);
  var_2 thread complete_killer(var_0, var_1);
  scripts\engine\utility::flag_set("_encstr_973C1C6D3CA9BBE347B0BA22906FDF0743A8F5E4C031F76DC168A29BE861");
  return var_2;
}

exfil_pilot(var_0, var_1, var_2) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_992C09B5C322C558EFDB03");
  var_3 = get_pilot_exfil(var_2);
  scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_8DD9272387EB8DC1DCD7DBCE36D7E42BCD6CBA2BEB38B48DED3AEB2DCDA6579CCBEB6BDE6759FAC40C", "_encstr_9A8507BA4040188D08");

  if(isDefined(var_3.target)) {
    var_4 = scripts\engine\utility::getStructArray(var_3.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_6 in var_4)
    var_6 thread proximity_spawn(var_6);
  }

  wait 1;
  objective_setlabel(var_1.objectiveindex, "_encstr_9AF7227519673681D95BB35DBB31A1EEEBE0CD1F102BFDD1FD65B97D91AD59AF4F88C487");
  objective_setshowprogress(var_1.objectiveindex, 0);
  objective_icon(var_1.objectiveindex, "_encstr_A3F2144852DF68A18B31BBA15774502D77BBC0709A2B");
  objective_position(var_1.objectiveindex, var_3.origin + (0, 0, -100));
  var_8 = spawn_evac_chopper(var_3);
  var_8.godmode = 1;
  var_8.health = 10000;
  var_8.maxhealth = 10000;
  vehicle_anims();
  var_8 script_model_anims();
  scripts\cp\cp_pickup_hostage::init_anims();
  var_8 spawnhelihvtexfilactors();
  var_8 thread leave_if_vip_dies(var_0, var_1);
  var_9 = 0;
  level notify("_encstr_B6FE1A0D59B15A23DB779BAFCAF0CC96D8AF9BD1C957B1477DD8B7B1", var_8.exfil_struct.origin);

  while(!var_9) {
    if(distancesquared(var_0.origin, var_8.exfil_struct.origin) < get_vip_close_to_exfil_dist_sq())
      var_9 = 1;

    wait 1;
  }

  level notify("_encstr_AD581CDB4007B7897382ABA02EB48846F1A8935F32FF7B37310ECCCB70E5", var_8);
  thread defend_while_chopper_arrives(var_1);
  var_1 waittill("_encstr_A9710C79AF9ED0C84277D9C79B7A");
  level notify("_encstr_9AD60EF02518379757389A8148BFCDDF");
  var_8 scripts\cp\infilexfil\blima_exfil::go_to_exfil_location(var_8.exfil_struct, 1);
  var_10 = anglesToForward(var_8.angles);
  var_11 = anglestoleft(var_8.angles);
  var_12 = var_8.origin;
  var_13 = var_12 + var_10 * 10 + var_11 * 64 + (0, 0, -110);
  objective_position(var_1.objectiveindex, var_13);
  objective_setlabel(var_1.objectiveindex, "_encstr_9AF7227519673681D95BB35DBB31A1EEEBE0CD1F102BFDD1FD65B97D91AD59AF4F88C487");
  var_14 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_13 + (0, 0, -200), 0, 64, 500);

  for(;;) {
    var_14 waittill("_encstr_8F5C086405E70FBA4B4A", var_15);

    if(!var_15 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(!isDefined(var_15.hostagecarried)) {
      continue;
    }
    var_16 = var_15.hostagecarried;
    var_16 notify("_encstr_A51E14CFB380E328D82063F7179A1DA30F8B93C8AACD");
    scripts\cp\cp_pickup_hostage::load_hvt(var_15, var_8);
    wait 1;
    break;
  }

  level notify("_encstr_96D81CB32D0EBED87B5891B219F5A3F6D7560F99A563EBB143DB381C95C9");
  scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_9A6D28F4B366079A6781820B63E7D2D75B966D6D58EB77A5773089F238E54B33F210C5F86C10AB21B32A", "_encstr_9A8507BA4040188D08");
  level thread evac_pilot(var_8);

  foreach(var_15 in level.players) {
    var_15 setsoundsubmix("_encstr_822C12BE606FB8DB03126818DA5FEFF0BF0B3326", 5);
    var_15 setplayermusicstate("_encstr_A13211C1259BD88BFF03FB61B32B3ED3282E47");
  }
}

get_vip_close_to_exfil_dist_sq() {
  if(isDefined(level.helidown_vip_close_to_exfil_dist_sq))
    return level.helidown_vip_close_to_exfil_dist_sq;

  return 12250000;
}

idle_exfilally_loop(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8EC80FCDD17B387DA5918D56EB16CD4BDA");

  for(;;)
    scripts\common\anim::anim_single_solo(var_0, "_encstr_852E15EA4C97655A0F384EBF5AAF0CA7B21520B50F738E", "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
}

spawnhelihvtexfilactors(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = "_encstr_96F32AA6F70BB21FFDAB49BB921231493B6EA02C598BF9812782C039ABAFF7A33709BE08F9972B8F4D8A8042";

  if(!isDefined(var_1))
    var_1 = "_encstr_929517C8C9AF69680841E357B8AEC930103FB63BAE085B5988";

  var_2 = self;
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
  var_3 setModel("_encstr_9AC718AB8029F13F41290B6854A584408CC3C15D3EEFBBEB8F02");
  var_3 useanimtree(level.scr_animtree["_encstr_B6F40B8D18B3B74D9970991A8A"]);
  var_3.animname = "_encstr_B6F40B8D18B3B74D9970991A8A";
  var_4 = getstartorigin(var_2.origin, var_2.angles, level.scr_anim["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_852E15EA4C97655A0F384EBF5AAF0CA7B21520B50F738E"]);
  var_5 = getstartangles(var_2.origin, var_2.angles, level.scr_anim["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_852E15EA4C97655A0F384EBF5AAF0CA7B21520B50F738E"]);
  var_3.origin = var_4;
  var_3.angles = var_5;
  var_3 linkTo(var_2);
  var_2.wmexfilally = var_3;
  var_2 thread idle_exfilally_loop(var_3);
}

get_pilot_exfil(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0.location + "_encstr_81E50B1FA2CE91EFF0330B94A0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = scripts\engine\utility::random(var_1);

  if(getdvarint("_encstr_960C13231028E0114F48A397621E1C7078B9D99F60") > 0) {
    var_3 = getdvarint("_encstr_960C13231028E0114F48A397621E1C7078B9D99F60");

    foreach(var_5 in var_1) {
      if(var_5.script_noteworthy == var_0.location + "_encstr_8E9808B723287757C116" + var_3)
        return var_5;
    }
  }

  return var_2;
}

remove_pilot_from_cockpit(var_0, var_1, var_2) {
  level notify("_encstr_9AD60EF02518379757389A8148BFCDDF");
  objective_setlabel(var_1.objectiveindex, &"_encstr_A62D23867FE778328EF11733D966D780251D1ECB4BAD407BD8C17FB7E17F9519A98355B5AD");
  var_0 wait_for_pilot_pickup(var_2);
  var_1 notify("_encstr_8F730B82D32028A1759BF7AFD5");

  if(isDefined(var_1)) {
    foreach(var_4 in level.players)
    objective_unpinforclient(var_1.objectiveindex, var_4);
  }

  var_2 thread kill_pilot_on_bleedout();
  level notify("_encstr_8FA60E511772B7189F5A61BB069DD8CD");
}

enable_pilot_carry(var_0) {
  var_0.bodymodel = "_encstr_951317DEBA8CD42FCFFCF7DAA7FB85D3B85F4BB88AA8984F30";
  var_0.pickuphintstring = &"_encstr_B1EF21FF41C1CD111FE9AB1D50819CF6BD3329137406F5271008AB342870B95767DD3F";
  var_0.drophintstring = "_encstr_ADD813912A8DD0E08BD2B0D86B5F23702284231FA5";
  var_0.nowaypoint = 1;
}

pilot_wait_for_rescue(var_0, var_1, var_2) {
  var_1 setHintString(&"_encstr_A12420E1F929854F7743BB36634FD4CDC4306921943333A75EBBA50D1F1B5C097D89");
  var_1 sethintdisplayrange(148);
  var_1 sethintdisplayfov(120);
  var_1 sethintonobstruction("_encstr_BD1805CB69C063");
  var_1 sethintrequiresholding(1);
  var_1 setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");

  while(!scripts\cp\utility::any_player_nearby(var_1.origin, 40000))
    wait 0.25;

  level.helidown_event_active = 1;
  objective_setlabel(var_0.objectiveindex, &"_encstr_860124F779164221B7A6408A828FC80A1C497FD3D96FFDF9BF565B3390F9E0DC446997373904");
  objective_setplayintro(var_0.objectiveindex, 0);
  objective_position(var_0.objectiveindex, var_2 gettagorigin("_encstr_AA7A07C20F94973F0B") + anglesToForward(var_2.angles) * -10);
}

evac_pilot(var_0, var_1) {
  var_0 vehicle_setspeed(5, 10);
  var_0 cleartargetyaw();
  var_0 setvehgoalpos(var_0.origin + (0, 0, 800), 1);
  wait 8;
  var_0 vehicle_setspeed(90, 10);
  var_0 setvehgoalpos(var_0.origin + (10000, 10000, 500));
  wait 20;

  if(isDefined(var_1) && isalive(var_1)) {
    var_1.nocorpse = 1;
    var_1 dodamage(var_1.health + 100, var_1.origin);
  }

  var_0 delete();
}

complete_killer(var_0, var_1) {
  level endon("_encstr_8DB01DF631A6AC6CD12DCEB2FA34591B2DBE91BDEE9BFAB6B41B8DBE86EC8E");
  var_1 endon("_encstr_8F730B82D32028A1759BF7AFD5");
  level endon("_encstr_8FA60E511772B7189F5A61BB069DD8CD");
  level scripts\engine\utility::_id_143A5("_encstr_BA552F329598AE3BEB98951647AFDE4CD4958D3A4BEC2BD7A12B36967D91EDBBDCF59BD10B9C47BEDE31A659B11DA56756", "_encstr_A1F2171A2BB19691F6EE9BAF3AA56B5639F55987E05AC995C8");

  if(isagent(self) && !istrue(self.onchopper))
    self dodamage(self.health + 100, self.origin);
  else if(isent(self) && !istrue(self.onchopper)) {
    if(isDefined(self.head))
      self.head delete();

    if(isDefined(self.body))
      self.body delete();

    self delete();
  }

  if(isDefined(var_0) && isent(var_0))
    var_0 thread remove_heli_corpse_after_timeout(1);

  level notify("_encstr_9AD60EF02518379757389A8148BFCDDF");
  level.helidown_event_active = 0;
  wait 0.5;

  if(isDefined(var_0))
    var_0 notify("_encstr_8DD20EA40BA09F1B7D3EEA12A3CFCF57");

  level notify("_encstr_8DB01DF631A6AC6CD12DCEB2FA34591B2DBE91BDEE9BFAB6B41B8DBE86EC8E");
}

remove_heli_corpse_after_timeout(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  level.helidown_corpse_present = 1;

  if(isDefined(var_1))
    wait(var_1);

  playsoundatpos(self.origin, "_encstr_B4E1196C83BE1327AFE6CB9CDAAF8D43DBE0C159C97DC693B0DCD0");
  playFX(level._effect["_encstr_B2251330933804F3D083928969B627FBC009B59811"], self.origin);
  playrumbleonposition("_encstr_8CE3093481205EB3B07FDF", self.origin);
  earthquake(0.35, 4, self.origin, 1000);
  radiusdamage(self.origin + (0, 0, 50), 750, 1000, 50);

  if(isDefined(self.clipmodel))
    self.clipmodel delete();

  if(isDefined(level.cut_interactions)) {
    foreach(var_3 in level.cut_interactions) {
      if(isDefined(var_3))
        var_3 delete();
    }

    level.cut_interactions = undefined;
  }

  destroynavobstacle(self.navobs);
  destroynavobstacle(self.navobs2);
  self hide();
  self waittill("_encstr_8DD20EA40BA09F1B7D3EEA12A3CFCF57");
  level.helidown_corpse_present = 0;
  self delete();
}

wait_for_door_cut(var_0, var_1) {
  var_1 endon("_encstr_AD75063D571AE108");
  var_2 = 0;

  for(;;) {
    level scripts\engine\utility::_id_143A7("_encstr_A9D506FF076BA7C2", "_encstr_BAD506B18B0B7842", "_encstr_B1D506B157477D99", "_encstr_A5D5066CEAE8BED0");
    var_2++;

    if(var_2 >= 4) {
      break;
    }
  }

  var_1 notify("_encstr_A6520CE959AA409DE713F6795BD3");

  if(isDefined(var_0)) {
    foreach(var_4 in level.players)
    objective_unpinforclient(var_0.objectiveindex, var_4);
  }
}

wait_for_door_cut_long(var_0, var_1) {
  var_1 endon("_encstr_AD75063D571AE108");
  level scripts\engine\utility::_id_143A7("_encstr_A9D506FF076BA7C2", "_encstr_BAD506B18B0B7842", "_encstr_B1D506B157477D99", "_encstr_A5D5066CEAE8BED0");
  var_1 notify("_encstr_A6520CE959AA409DE713F6795BD3");

  if(isDefined(var_0)) {
    foreach(var_3 in level.players)
    objective_unpinforclient(var_0.objectiveindex, var_3);
  }
}

pilot_rescue_objective_think(var_0, var_1) {
  var_1 endon("_encstr_A60A075AC355CF2BD8");
  var_1 endon("_encstr_992C09B5C322C558EFDB03");
  var_1 endon("_encstr_AD75063D571AE108");

  for(;;) {
    foreach(var_3 in level.players) {
      if(!var_3 scripts\cp\utility::is_valid_player()) {
        if(isDefined(var_3.inhackring)) {
          objective_unpinforclient(var_0.objectiveindex, var_3);
          var_3.inhackring = undefined;
        }

        continue;
      }

      if(distancesquared(var_3.origin, var_1.origin + (0, 0, -20)) > 16900) {
        if(isDefined(var_3.inhackring)) {
          objective_unpinforclient(var_0.objectiveindex, var_3);
          var_3.inhackring = undefined;
        }

        continue;
      }

      if(!istrue(var_3.inhackring)) {
        objective_pinforclient(var_0.objectiveindex, var_3);
        var_3.inhackring = 1;
      }
    }

    wait 0.25;
  }
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

script_model_anims() {
  level.scr_animtree["_encstr_95A70A376069C16A0F04E398"] = #animtree;
  level.scr_anim["_encstr_95A70A376069C16A0F04E398"]["_encstr_9A1C0F43AC365AC8F6BB9BAFCAE1994B63"] = % _encstr_8BB81CD00B976931DAEC990806525BD0111F10F0E37F803511D28E2B5E3A;
  level.scr_animname["_encstr_95A70A376069C16A0F04E398"]["_encstr_9A1C0F43AC365AC8F6BB9BAFCAE1994B63"] = "_encstr_8BB81CD00B976931DAEC990806525BD0111F10F0E37F803511D28E2B5E3A";
  level.scr_anim["_encstr_95A70A376069C16A0F04E398"]["_encstr_970F1451174233A8FF4B504EF7C0F07B1A972BC1AB7A"] = % _encstr_8F3F21CE5BC67A4B10837C8F5BD528A3EBF0ABF3754FB18DEF1ADEBAD30D78E40B9C3D;
  level.scr_animname["_encstr_95A70A376069C16A0F04E398"]["_encstr_970F1451174233A8FF4B504EF7C0F07B1A972BC1AB7A"] = "_encstr_8F3F21CE5BC67A4B10837C8F5BD528A3EBF0ABF3754FB18DEF1ADEBAD30D78E40B9C3D";
  level.scr_animtree["_encstr_B1190448CD80"] = #animtree;
  level.scr_anim["_encstr_B1190448CD80"]["_encstr_9A1C0F43AC365AC8F6BB9BAFCAE1994B63"] = % _encstr_B22D1A3823F1E322AB5109E832EB48AB2679D818FB19393977480C75;
  level.scr_animname["_encstr_B1190448CD80"]["_encstr_9A1C0F43AC365AC8F6BB9BAFCAE1994B63"] = "_encstr_B22D1A3823F1E322AB5109E832EB48AB2679D818FB19393977480C75";
  level.scr_anim["_encstr_B1190448CD80"]["_encstr_970F1451174233A8FF4B504EF7C0F07B1A972BC1AB7A"] = % _encstr_88D81FD8039F1149D2F491300E4A53D809270888FB47883D29DC94ADA9F281A075;
  level.scr_animname["_encstr_B1190448CD80"]["_encstr_970F1451174233A8FF4B504EF7C0F07B1A972BC1AB7A"] = "_encstr_88D81FD8039F1149D2F491300E4A53D809270888FB47883D29DC94ADA9F281A075";
  level.scr_animtree["_encstr_BD9E0EA7DBEA038131D343F0A34890C0"] = #animtree;
  level.scr_anim["_encstr_BD9E0EA7DBEA038131D343F0A34890C0"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"] = % _encstr_8D2425CDC8C9AFC6E0F5A1BDE6E82CD9CAEBC8E47B07F66633BE4CC65AB616AFC6AF1336B46B85;
  level.scr_animname["_encstr_BD9E0EA7DBEA038131D343F0A34890C0"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"] = "_encstr_8D2425CDC8C9AFC6E0F5A1BDE6E82CD9CAEBC8E47B07F66633BE4CC65AB616AFC4AF1336B46B85";
  level.scr_anim["_encstr_BD9E0EA7DBEA038131D343F0A34890C0"]["_encstr_ACD10D136396B62CD7324EF607FA93"] = % _encstr_82192596370B974950675070CF8CC12F8211859E4D83AF912E4F08604FBD99275B890E29A40A7B;
  level.scr_animname["_encstr_BD9E0EA7DBEA038131D343F0A34890C0"]["_encstr_ACD10D136396B62CD7324EF607FA93"] = "_encstr_82192596370B974950675070CF8CC12F8211859E4D83AF912E4F08604FBD992759890E29A40A7B";
}

_id_11FC3(var_0, var_1) {
  var_1 notify("_encstr_BE450C38FF80DB9D8D08C1AA90F1");
  var_0 notify("_encstr_83AE16E0B51150C39A1F374143E3AFC0A6CB081E1C7D488B");
  var_2 = var_1.wmexfilally;
  var_3 = getcompleteweaponname("_encstr_9A0D0C4B54606F8F63C84B8B53EE");
  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_3, undefined, undefined, 1);
  var_4 = var_0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_3, 0);
  var_0 scripts\engine\utility::_id_143B9(1, "_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  var_0 resetcarryobject();
  var_0 setstance("_encstr_A5AD069B231F0BAF");
  var_5 = var_0.hostagecarried;
  var_5.onchopper = 1;
  var_0 unlink();
  var_5 unlink();
  var_5.body unlink();
  var_0 allowcrouch(0);
  var_5.body useanimtree(level.scr_animtree["_encstr_B1190448CD80"]);
  var_5.body.animname = "_encstr_B1190448CD80";
  var_0 thread scripts\cp\cp_pickup_hostage::create_player_rig(var_0, "_encstr_95DC110B1D69C0BD3367CDFBF3C97630093551");
  var_1 scripts\common\anim::anim_first_frame_solo(var_0.player_rig, "_encstr_B2D10D8DB84A58F9504C35D8EB29B4");
  scripts\cp\cp_pickup_hostage::link_player_to_rig(var_0, 0.4);
  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
  var_6 setModel("_encstr_9AC718AB8029F13F41290B6854A584408CC3C15D3EEFBBEB8F02");
  var_6 useanimtree(level.scr_animtree["_encstr_B6F40B8D18B3B74D9970991A8A"]);
  var_6.animname = "_encstr_B6F40B8D18B3B74D9970991A8A";
  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
  var_7 setModel(var_5.bodymodel);
  var_7 useanimtree(level.scr_animtree["_encstr_BAB607298EEB09D45F"]);
  var_7.animname = "_encstr_BAB607298EEB09D45F";

  if(isDefined(var_5.head)) {
    var_7.head = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
    var_7.head setModel(var_5.headmodel);
    var_7.head linkTo(var_7, "_encstr_BDAB07BA596A43E9EB", (-9, 1, 0), (0, 0, 0));
    var_7.head.animname = "_encstr_BAB607298EEB09D45F";
    var_7.head useanimtree(level.scr_animtree["_encstr_BAB607298EEB09D45F"]);
    var_7.head showonlytoplayer(var_0);
  }

  var_7 showonlytoplayer(var_0);
  var_6 showonlytoplayer(var_0);
  var_2 show();
  var_2 hidefromplayer(var_0);
  var_5.body show();
  var_5.body hidefromplayer(var_0);

  if(isDefined(var_5.head))
    var_5.head hidefromplayer(var_0);

  var_8 = getstartorigin(var_1.origin, var_1.angles, level.scr_anim["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"]);
  var_9 = getstartangles(var_1.origin, var_1.angles, level.scr_anim["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"]);
  var_10 = getstartorigin(var_1.origin, var_1.angles, level.scr_anim["_encstr_81480E01A90C8BB179D1D0CC784123D1"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"]);
  var_11 = getstartangles(var_1.origin, var_1.angles, level.scr_anim["_encstr_81480E01A90C8BB179D1D0CC784123D1"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"]);
  var_12 = getstartorigin(var_1.origin, var_1.angles, level.scr_anim["_encstr_BAB607298EEB09D45F"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"]);
  var_13 = getstartangles(var_1.origin, var_1.angles, level.scr_anim["_encstr_BAB607298EEB09D45F"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"]);
  var_2.origin = var_8;
  var_2.angles = var_9;
  var_6.origin = var_10;
  var_6.angles = var_11;
  var_7.origin = var_12;
  var_7.angles = var_13;
  var_5.origin = var_12;
  var_5.angles = var_13;
  var_6 linkTo(var_1);
  var_7 linkTo(var_1);
  var_5 linkTo(var_1);
  var_1.vmexfilally = var_6;
  var_1.vmhvt = var_7;
  var_14 = getstartorigin(var_1.origin, var_1.angles, level.scr_anim["_encstr_95DC110B1D69C0BD3367CDFBF3C97630093551"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"]);
  var_15 = getstartangles(var_1.origin, var_1.angles, level.scr_anim["_encstr_95DC110B1D69C0BD3367CDFBF3C97630093551"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"]);
  var_0 allowcrouch(0);
  var_0 setstance("_encstr_A5AD069B231F0BAF");
  var_2 notify("_encstr_8EC80FCDD17B387DA5918D56EB16CD4BDA");
  var_1 thread scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, "_encstr_B2D10D8DB84A58F9504C35D8EB29B4", "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_1 thread scripts\common\anim::anim_single_solo(var_6, "_encstr_B2D10D8DB84A58F9504C35D8EB29B4", "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_1 thread scripts\common\anim::anim_single_solo(var_2, "_encstr_B2D10D8DB84A58F9504C35D8EB29B4", "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_1 thread scripts\common\anim::anim_single_solo(var_7, "_encstr_B2D10D8DB84A58F9504C35D8EB29B4", "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_1 thread scripts\common\anim::anim_single_solo(var_5.body, "_encstr_B2D10D8DB84A58F9504C35D8EB29B4", "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_16 = getanimlength(level.scr_anim["_encstr_95DC110B1D69C0BD3367CDFBF3C97630093551"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"]);
  var_17 = getanimlength(level.scr_anim["_encstr_B1190448CD80"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"]);
  wait(var_16);
  var_0 setstance("_encstr_A5AD069B231F0BAF");
  var_0 notify("_encstr_BE840BF2FFD8B0A4DB6EE31FA1");
  var_0 scripts\cp\cp_weapons::_takeweapon(var_3);
  var_0 switchtoweapon(var_0.restoreweapon);
  var_0 allowcrouch(1);
  scripts\cp\cp_pickup_hostage::hostagedrop(var_0, var_0.hostagecarried, var_0.hostagecarried.origin, 0, 0.5, 1, 1);
  wait(var_17 - var_16);
  var_5.body linkTo(var_5);

  if(isDefined(var_5.head))
    var_5.head linkTo(var_5.body);

  var_5 linkTo(var_1);

  if(isDefined(var_7.head))
    var_7.head delete();

  var_7 delete();
  var_6 delete();
  var_5.body show();

  if(isDefined(var_5.head))
    var_5.head show();

  var_2 show();
  var_5.body scriptmodelplayanim("_encstr_B2743083E5828FFF936178E713439BEF6269881B1F1777E111C908904340B867C4BEA02C3161A668CDDBD338417BC02D5FAB");
  var_2 scriptmodelplayanim("_encstr_A20D2FF7F10EC153A8CE04CD63A0999A6D6F537B7FB78A0E60D6BE15D8B0A151A1D7EFBBD15531CFD0DBB2DD36B8E49A93");
}

hostage_price_idle(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_0 scriptmodelplayanim(level.scr_anim[var_0.animname]["_encstr_970F1451174233A8FF4B504EF7C0F07B1A972BC1AB7A"]);

    if(isDefined(var_0.head))
      var_0.head scriptmodelplayanim(level.scr_anim[var_0.head.animname]["_encstr_970F1451174233A8FF4B504EF7C0F07B1A972BC1AB7A"]);

    self.exfil_helpers[0] scriptmodelplayanim(level.scr_anim[self.exfil_helpers[0].animname]["_encstr_970F1451174233A8FF4B504EF7C0F07B1A972BC1AB7A"]);
    var_1 = getanimlength(level.scr_anim[self.exfil_helpers[0].animname]["_encstr_970F1451174233A8FF4B504EF7C0F07B1A972BC1AB7A"]);
    wait(var_1);
  }
}

spawnactors() {
  if(!isDefined(self.exfil_helpers))
    self.exfil_helpers = [];

  self.exfil_helpers[self.exfil_helpers.size] = spawn_anim_model("_encstr_95A70A376069C16A0F04E398", "_encstr_9AD01136187923E791B06F67D06B9509DD203B", "_encstr_BDD61A99ABB163C4BD23E5F5A12B4EBDBE0EC95A36B2BED5274C2CE6");
}

spawn_anim_model(var_0, var_1, var_2, var_3) {
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
  var_4 setModel(var_2);

  if(isDefined(var_3)) {
    var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
    var_5 setModel(var_3);
    var_5 linkTo(var_4, "_encstr_8EEC09159F6238030BFA23", (0, 0, 0), (0, 0, 0));
    var_4.head = var_5;
    var_4 thread scripts\engine\utility::delete_on_death(var_5);
  }

  var_4.animname = var_0;
  var_4 useanimtree(level.scr_animtree[var_4.animname]);

  if(isDefined(var_1)) {
    thread scripts\engine\utility::delete_on_death(var_4);
    var_4 linkTo(self, var_1, (0, 0, 0), (0, 0, 0));
  }

  return var_4;
}

actor_animloop(var_0, var_1, var_2, var_3) {
  self endon(var_2);
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    scripts\common\anim::anim_single(var_0, var_1, var_3);
    var_4 = getanimlength(level.scr_anim[var_0[0].animname][var_1]);
    wait(var_4);
  }
}

#using_animtree("_encstr_810A1AEA3847B3D39854493595C316A9992BE66BE3D770C29F5B901A");

vehicle_anims() {
  level.scr_animtree["_encstr_BD9E0EA7DBEA038131D343F0A34890C0"] = #animtree;
}

escort_vip_to_chopper(var_0, var_1, var_2) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 thread complete_killer(var_1, var_2);
  var_0 thread play_escort_pain_vo();
  var_0 waittill("_encstr_990D06B916D95691");
  var_0.trigger makeusable();
  var_0 waittill("_encstr_B1DA09D3DB3FF1756059F7");
  var_0 playSound("_encstr_91A32719A819D0FF0F49BB20E3E7B6A8AA0BB383673A58C9579356092AE7E698C9663F2BCE67A1AED2");
  create_escort_health_objective(var_0);
  var_0 thread scripts\cp\cp_vip::vip_damage_monitor();
  var_0.ignoreme = 1;
  level notify("_encstr_9AD60EF02518379757389A8148BFCDDF");
  level.helidown_event_active = 1;
  var_2 notify("_encstr_8F730B82D32028A1759BF7AFD5");
  scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_84B627C8C3BEC638CDD7BDECD8AF4E2BB98DD556BE38A563EDD1D7B24DB2C61DF5CCF65DCD91D79860", "_encstr_9A8507BA4040188D08");
  var_3 = spawn_vip_escort_chopper(var_1, var_2);
  wait 3;

  if(isDefined(var_3.exfil_struct.target)) {
    var_4 = scripts\engine\utility::getStructArray(var_3.exfil_struct.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_6 in var_4)
    var_6 thread proximity_spawn(var_6);
  }

  var_0 wait_for_vip_near_heli(var_3, var_2);
}

play_escort_pain_vo() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B1DA09D3DB3FF1756059F7");
  self endon("_encstr_990D06B916D95691");

  for(;;) {
    wait(randomintrange(15, 30));
    self playSound("_encstr_ABA3271987FAC6E0B9FAE0C647D793CAB9D8BA59D70E96B1BDD17D59D4956C3ABE66DBAE9B8CF591C0");
  }
}

wait_for_vip_near_heli(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(distancesquared(self.origin, var_0.exfil_struct.origin) < 9000000) {
      break;
    }

    wait 1;
  }

  var_0 thread leave_if_vip_dies(self, var_1);
  thread defend_while_chopper_arrives(var_1);
  var_1 waittill("_encstr_A9710C79AF9ED0C84277D9C79B7A");
  level notify("_encstr_9AD60EF02518379757389A8148BFCDDF");
  var_0 scripts\cp\infilexfil\blima_exfil::go_to_exfil_location(var_0.exfil_struct, 1);
  var_2 = anglesToForward(var_0.angles);
  var_3 = anglestoleft(var_0.angles);
  var_4 = var_0.origin;
  var_5 = var_4 + var_2 * 10 + var_3 * 64 + (0, 0, -110);
  objective_position(var_1.objectiveindex, var_5);

  for(;;) {
    if(distancesquared(self.origin, var_0.exfil_struct.origin) < 1000000) {
      break;
    }

    wait 1;
  }

  board_chopper(var_0, self);
  self notify("_encstr_8A12060D5BA9C745");
  wait 2;
  level thread evac_pilot(var_0, self);
}

leave_if_vip_dies(var_0, var_1) {
  var_0 endon("_encstr_8A12060D5BA9C745");
  self endon("_encstr_AD75063D571AE108");
  scripts\engine\utility::waittill_any_ents_return(var_1, "_encstr_9369093BB483AF325A5991", var_0, "_encstr_992C09B5C322C558EFDB03");
  self notify("_encstr_912D0C88C37F03B7D2A6CE5ABFFB");

  if(self vehicle_getspeed() > 1)
    self waittill("_encstr_8B7205D9ED5958");

  if(istrue(self.going_to_exfil))
    thread evac_pilot(self);
  else {
    if(isDefined(var_0) && isalive(var_0)) {
      var_0.nocorpse = 1;
      var_0 dodamage(var_0.health + 100, var_0.origin);
    }

    self delete();
  }
}

defend_while_chopper_arrives(var_0) {
  objective_setlabel(var_0.objectiveindex, &"_encstr_AB7F2490AF08A33A491F999A472135FBDAA52869146477A2F22BE0967B61C92F703F60E15F55");
  objective_setshowprogress(var_0.objectiveindex, 1);
  objective_setprogress(var_0.objectiveindex, 0);
  var_1 = 60;
  var_2 = 60;

  for(;;) {
    wait 1;
    var_2--;
    objective_setprogress(var_0.objectiveindex, var_2 / var_1);

    if(var_2 <= 15)
      var_0 notify("_encstr_A9710C79AF9ED0C84277D9C79B7A");

    if(var_2 <= 0)
      return;
  }
}

spawn_vip_escort_chopper(var_0, var_1) {
  objective_setlabel(var_1.objectiveindex, "_encstr_9AF7227519673681D95BB35DBB31A1EEEBE0CD1F102BFDD1FD65B97D91AD59AF4F88C487");
  objective_setshowprogress(var_1.objectiveindex, 0);
  objective_icon(var_1.objectiveindex, "_encstr_A3F2144852DF68A18B31BBA15774502D77BBC0709A2B");
  var_2 = get_pilot_exfil(var_0);
  var_3 = spawn_evac_chopper(var_2);
  var_3.godmode = 1;
  var_3.health = 10000;
  var_3.maxhealth = 10000;
  objective_position(var_1.objectiveindex, var_2.origin + (0, 0, -100));
  return var_3;
}

#using_animtree("_encstr_B40101");

spawn_evac_chopper(var_0) {
  var_1 = scripts\common\vehicle::vehicle_spawn(scripts\engine\utility::getStruct("_encstr_A75C13AFF12B704971FAB3B0F2191FE84F7037AD42", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
  var_1.vehicle_skipdeathmodel = 1;
  var_1.godmode = 1;
  var_1.health = 10000;
  var_1.maxhealth = 10000;
  var_1.script_disconnectpaths = 0;
  var_1.death_fx_on_self = 1;
  var_1.exfil_struct = var_0;
  var_1 vehicleplayanim(%_encstr_BEEC15FD7F38492B918062AA2EFD673D60E74F4FD168CD);
  var_0.smoke_canister = scripts\cp\cp_objective_mechanics::smoke_canister_spawn(var_0.origin, 1);
  scripts\cp\infilexfil\blima_exfil::spawn_vehicle_actors(var_1);
  var_1 scripts\cp\infilexfil\blima_exfil::heli_mg_create();
  return var_1;
}

board_chopper(var_0, var_1) {
  var_1 notify("_encstr_ABCC10DC47DB07F5CEB483BE33BDB136DBEE");
  var_1.trigger makeunusable();
  var_1.trigger delete();
  var_1 hudoutlinedisable();
  var_1 notify("_encstr_B8D910023F20F5D3AB27F802D659C8813540");
  var_1 setCanDamage(0);
  var_1.ignoreme = 1;
  var_1.ignoreall = 1;
  var_1.playing_skit = 1;
  var_2 = get_closest_heli_entrance(var_1, var_0);
  var_1.goalradius = 8;
  var_1 setgoalpos(var_2.origin);
  var_1 scripts\engine\utility::_id_143A5("_encstr_8B7205D9ED5958", "_encstr_A3130D9AF069D2310E87C1D9C03A82");
  var_1.old_weapon = var_1.weapon;
  var_1.fists_weapon = scripts\cp\cp_weapon::buildweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C", [], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
  var_1 giveweapon(var_1.fists_weapon);
  var_1 takeweapon(var_1.old_weapon);
  var_1 setspawnweapon(var_1.fists_weapon);
  var_1 setplayerangles(var_2.angles);
  var_1 forceteleport(var_2.origin, var_2.angles);
  var_1 scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var_1 aisetanim("_encstr_84610D49100897C2DF809A03583BFF", var_2.animindex);
  var_3 = getanimlength(var_2.xanim);
  wait(var_3);
  var_1 linkTo(var_0);
  var_1 playerlinkedoffsetenable();
  var_1.nodamage = 1;
  var_1 thread vip_idle_loop();
  var_1 notify("_encstr_A51E14CFB380E328D82063F7179A1DA30F8B93C8AACD");
}

get_closest_heli_entrance(var_0, var_1) {
  var_2 = get_entrance_pos(var_0, var_1, "_encstr_845112BDF753F8480C3CC059A9ED50AC3A0B773D");
  var_3 = get_entrance_pos(var_0, var_1, "_encstr_A251128B8377B92A20106D76CE3068624331A77B");
  return scripts\engine\utility::getclosest(var_0.origin, [var_2, var_3]);
}

get_entrance_pos(var_0, var_1, var_2) {
  var_3 = var_0 scripts\asm\asm::asm_lookupanimfromalias("_encstr_84610D49100897C2DF809A03583BFF", var_2);
  var_4 = var_0 scripts\asm\asm::asm_getxanim("_encstr_84610D49100897C2DF809A03583BFF", var_3);
  var_5 = var_1 gettagorigin("_encstr_9AD01136187923E791B06F67D06B9509DD203B");
  var_6 = var_1 gettagangles("_encstr_9AD01136187923E791B06F67D06B9509DD203B");
  var_7 = spawnStruct();
  var_7.origin = getstartorigin(var_5, var_6, var_4);
  var_7.angles = getstartangles(var_5, var_6, var_4);
  var_7.animindex = var_3;
  var_7.xanim = var_4;
  return var_7;
}

vip_idle_loop() {
  self endon("_encstr_AD75063D571AE108");
  scripts\asm\shared\mp\utility::bunkerinteriorkeypads("_encstr_A52015DB106311B6A88073F6D93A9B2763EBFF48BAF1C5");
}

create_escort_health_objective(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_A51E14CFB380E328D82063F7179A1DA30F8B93C8AACD");
  var_1 = 75;
  var_2 = scripts\cp\cp_objectives::requestworldid("_encstr_8FC70B38A5D8F647BEC8F6BBCD", 15);
  objective_state(var_2, "_encstr_AF5A081BBAC993AC73A3");
  objective_icon(var_2, "_encstr_B4291521350731F336881D1031EF0693D3CF806BD7933D");
  objective_onentity(var_2, var_0);
  objective_setbackground(var_2, 0);
  objective_setprogressteam(var_2, "_encstr_9A8507BA4040188D08");
  objective_setshowprogress(var_2, 1);
  objective_setprogress(var_2, 1);
  objective_setplayintro(var_2, 0);
  objective_setlabel(var_2, &"_encstr_B4F3248641F509A4F54DCA295ABE7A90942A348A29B28A6A97523994AA252A44AF415298E92A");
  objective_setzoffset(var_2, var_1);
  var_0.objnum = var_2;
  var_0 thread destroy_bleedout_timer();
}

destroy_bleedout_timer() {
  var_0 = self.objnum;
  scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_A51E14CFB380E328D82063F7179A1DA30F8B93C8AACD");
  objective_delete(var_0);
}

kill_pilot_on_bleedout() {
  self endon("_encstr_AF9408159532F05D779A");
  self endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_992C09B5C322C558EFDB03");

  if(isDefined(self.carrier))
    scripts\cp\cp_pickup_hostage::hostagedrop(undefined, undefined, self.origin, undefined, 0.5, 0, 1);

  scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_930A26B178A16857A791B09B8A3F0E2BC273EB3BBFD2F0912F3B8EE1928F4E4011CE4BBB24F18AC7", "_encstr_9A8507BA4040188D08");
  scripts\cp\cp_hud_message::teamhudtutorialmessage(&"_encstr_8FFC24B7C757985AB01FC6493B97FFA4779F1CD941C0E7E54980FF192B45A9FF3459E8895599", "_encstr_9A8507BA4040188D08", 5);

  if(isDefined(self.head))
    self.head delete();

  self delete();
}

proximity_spawn(var_0, var_1) {
  if(isstruct(var_0)) {
    var_2 = var_0.origin;
    var_3 = 128;

    if(isDefined(var_0.height))
      var_3 = int(var_0.height);

    var_4 = 4096;

    if(isDefined(var_0.radius))
      var_4 = int(var_0.radius);
  } else {
    var_2 = var_0;
    var_3 = 128;
    var_4 = 4096;
  }

  var_5 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_2, 0, var_4, var_3);
  var_6 = scripts\engine\utility::waittill_any_ents_return(level, "_encstr_9AD60EF02518379757389A8148BFCDDF", level, "_encstr_8DB01DF631A6AC6CD12DCEB2FA34591B2DBE91BDEE9BFAB6B41B8DBE86EC8E", var_5, "_encstr_8F5C086405E70FBA4B4A");

  if(var_6 == "_encstr_8F5C086405E70FBA4B4A") {
    if(isDefined(var_1))
      scripts\cp\cp_modular_spawning::run_spawn_module(var_1);
    else
      scripts\cp\cp_modular_spawning::run_spawn_module(var_0.target);
  }

  var_5 delete();
}

register_spawn_groups() {
  var_0 = scripts\cp\cp_modular_spawning::registerambientgroup;

  if(scripts\cp\pvpe\pvpe::pvpe_enabled()) {
    var_1 = [scripts\cp\cp_modular_spawning::waittill_spawn_notify_after_count, "_encstr_8E281D149DA02ABEB2E6566BE57DA052D76ED1C293A3D7E638C2BB9B4BCD3B"];
    var_2 = [scripts\cp\cp_modular_spawning::override_spawner_aitypes, "_encstr_AD07034A38", "_encstr_BE1904DCDA9D"];
    var_3 = [var_2, ::end_spawn_group];
    [[var_0]]("_encstr_A7F50E43695A8D4FB2EFEF1D4507A623", 0, 0, 0, var_1, undefined, "_encstr_A7F50E43695A8D4FB2EFEF1D4507A623", var_2, "_encstr_AC281849F90AE03D47B396F89AEFF8D2E942EBC36E77A0FE3FCA", 8);
    [[var_0]]("_encstr_AC281849F90AE03D47B396F89AEFF8D2E942EBC36E77A0FE3FCA", 0, 0, 0, var_1, 0, "_encstr_AC281849F90AE03D47B396F89AEFF8D2E942EBC36E77A0FE3FCA", var_3, undefined, undefined);
    [[var_0]]("_encstr_AC281849F90AE03D47B396F89AEFF8D2E942EBC36E77A0FE3FCA", 0, 0, 0, var_1, 0, "_encstr_85E520607AA35048822BEF912FEED1866F2359C8325B18085E15E7A74654706573AB", var_3, undefined, undefined);
    [[var_0]]("_encstr_AC281849F90AE03D47B396F89AEFF8D2E942EBC36E77A0FE3FCA", 0, 0, 0, var_1, 0, "_encstr_B89C221A169C9B599B6ED763B71B7DCCEBE459A5DC99ED27D8ACAFB9CD9607959CCDBE46", var_3, undefined, undefined);
    [[var_0]]("_encstr_AC281849F90AE03D47B396F89AEFF8D2E942EBC36E77A0FE3FCA", 0, 0, 0, var_1, 0, "_encstr_998E1CB0E26A2551CF7BA0214FA7DE27997B40306A076F8B5795A82648CF", var_3, undefined, undefined);
    [[var_0]]("_encstr_AC281849F90AE03D47B396F89AEFF8D2E942EBC36E77A0FE3FCA", 0, 0, 0, var_1, 0, "_encstr_81701A9B91DE658D63471120BF57470FF07AB9AC200615BA7E826185", var_3, undefined, undefined);
    [[var_0]]("_encstr_96AB0D56B9B17BC93AF5B17B8DEB99", 0, 0, 0, 0.1, undefined, "_encstr_A7F50E43695A8D4FB2EFEF1D4507A623", var_2, "_encstr_829517FFCBB8CFBBAD2F3B3FBFC05707D8917485C1809AE20D", 8);
    [[var_0]]("_encstr_829517FFCBB8CFBBAD2F3B3FBFC05707D8917485C1809AE20D", 0, 0, 0, var_1, 0, "_encstr_829517FFCBB8CFBBAD2F3B3FBFC05707D8917485C1809AE20D", var_3, undefined, undefined);
    [[var_0]]("_encstr_829517FFCBB8CFBBAD2F3B3FBFC05707D8917485C1809AE20D", 0, 0, 0, var_1, 0, "_encstr_85E520607AA35048822BEF912FEED1866F2359C8325B18085E15E7A74654706573AB", var_3, undefined, undefined);
    [[var_0]]("_encstr_829517FFCBB8CFBBAD2F3B3FBFC05707D8917485C1809AE20D", 0, 0, 0, var_1, 0, "_encstr_B89C221A169C9B599B6ED763B71B7DCCEBE459A5DC99ED27D8ACAFB9CD9607959CCDBE46", var_3, undefined, undefined);
    [[var_0]]("_encstr_829517FFCBB8CFBBAD2F3B3FBFC05707D8917485C1809AE20D", 0, 0, 0, var_1, 0, "_encstr_998E1CB0E26A2551CF7BA0214FA7DE27997B40306A076F8B5795A82648CF", var_3, undefined, undefined);
    [[var_0]]("_encstr_A2D710A5080731FB26F83B7BA0785F1FA797", 0, 0, 0, var_1, undefined, "_encstr_A2D710A5080731FB26F83B7BA0785F1FA797", var_3, undefined, undefined);
    [[var_0]]("_encstr_B6D71012A81719062E0DC0D61310EFCAC778", 0, 0, 0, var_1, undefined, "_encstr_B6D71012A81719062E0DC0D61310EFCAC778", var_3, undefined, undefined);
    [[var_0]]("_encstr_B4D71036F66CAF99BEACC3334BB1EBC4FAC6", 0, 0, 0, var_1, undefined, "_encstr_B4D71036F66CAF99BEACC3334BB1EBC4FAC6", var_3, "_encstr_99E91A81082ED9679F252BDCA180598FE1FF56DA3877F22117E383B9", undefined);
    [[var_0]]("_encstr_99E91A81082ED9679F252BDCA180598FE1FF56DA3877F22117E383B9", 0, 0, 0, var_1, undefined, "_encstr_99E91A81082ED9679F252BDCA180598FE1FF56DA3877F22117E383B9", var_3, undefined, undefined);
    [[var_0]]("_encstr_ACCF0E637B36AF66D7B20F669663FAC8", 0, 0, 0, var_1, undefined, "_encstr_ACCF0E637B36AF66D7B20F669663FAC8", var_2, "_encstr_9A48182C885147FA8F2BA37A58D1293A0EEEADD190593FF29F68", 10);
    [[var_0]]("_encstr_9A48182C885147FA8F2BA37A58D1293A0EEEADD190593FF29F68", 0, 0, undefined, var_1, 0, "_encstr_9A48182C885147FA8F2BA37A58D1293A0EEEADD190593FF29F68", var_3, undefined, undefined);
    [[var_0]]("_encstr_9A48182C885147FA8F2BA37A58D1293A0EEEADD190593FF29F68", 0, 0, undefined, var_1, 0, "_encstr_BD881FB1DBC6EB33AF2B3C332D1BBE64AF39594BB999ED93C656EBDC73A538AC93", var_3, undefined, undefined);
  } else {
    [[var_0]]("_encstr_A7F50E43695A8D4FB2EFEF1D4507A623", 4, 4, 4, 0.1, undefined, "_encstr_A7F50E43695A8D4FB2EFEF1D4507A623", undefined, "_encstr_AC281849F90AE03D47B396F89AEFF8D2E942EBC36E77A0FE3FCA", 8);
    [[var_0]]("_encstr_AC281849F90AE03D47B396F89AEFF8D2E942EBC36E77A0FE3FCA", 5, 6, 100, [::wave_reinforce, 3, 10], 0, "_encstr_AC281849F90AE03D47B396F89AEFF8D2E942EBC36E77A0FE3FCA", ::end_spawn_group, undefined, undefined);
    [[var_0]]("_encstr_AC281849F90AE03D47B396F89AEFF8D2E942EBC36E77A0FE3FCA", 1, 2, 100, [::wave_reinforce, 3, 25], 0, "_encstr_85E520607AA35048822BEF912FEED1866F2359C8325B18085E15E7A74654706573AB", ::end_spawn_group, undefined, undefined);
    [[var_0]]("_encstr_AC281849F90AE03D47B396F89AEFF8D2E942EBC36E77A0FE3FCA", 1, 1, 100, [::wave_reinforce, 20, 25], 0, "_encstr_B89C221A169C9B599B6ED763B71B7DCCEBE459A5DC99ED27D8ACAFB9CD9607959CCDBE46", ::end_spawn_group, undefined, undefined);
    [[var_0]]("_encstr_AC281849F90AE03D47B396F89AEFF8D2E942EBC36E77A0FE3FCA", 1, 2, 100, [::wave_reinforce, 20, 25], 0, "_encstr_998E1CB0E26A2551CF7BA0214FA7DE27997B40306A076F8B5795A82648CF", ::end_spawn_group, undefined, undefined);
    [[var_0]]("_encstr_AC281849F90AE03D47B396F89AEFF8D2E942EBC36E77A0FE3FCA", 2, 5, 100, [::wave_reinforce, 1, 10, ::reinforce_after_door_section], 0, "_encstr_81701A9B91DE658D63471120BF57470FF07AB9AC200615BA7E826185", ::end_spawn_group, undefined, undefined);
    [[var_0]]("_encstr_96AB0D56B9B17BC93AF5B17B8DEB99", 4, 4, 4, 0.1, undefined, "_encstr_A7F50E43695A8D4FB2EFEF1D4507A623", undefined, "_encstr_829517FFCBB8CFBBAD2F3B3FBFC05707D8917485C1809AE20D", 8);
    [[var_0]]("_encstr_829517FFCBB8CFBBAD2F3B3FBFC05707D8917485C1809AE20D", 5, 8, 100, [::wave_reinforce, 1, 10], 0, "_encstr_829517FFCBB8CFBBAD2F3B3FBFC05707D8917485C1809AE20D", ::end_spawn_group, undefined, undefined);
    [[var_0]]("_encstr_829517FFCBB8CFBBAD2F3B3FBFC05707D8917485C1809AE20D", 1, 2, 100, [::wave_reinforce, 1, 30], 0, "_encstr_85E520607AA35048822BEF912FEED1866F2359C8325B18085E15E7A74654706573AB", ::end_spawn_group, undefined, undefined);
    [[var_0]]("_encstr_829517FFCBB8CFBBAD2F3B3FBFC05707D8917485C1809AE20D", 1, 1, 100, [::wave_reinforce, 1, 30], 0, "_encstr_B89C221A169C9B599B6ED763B71B7DCCEBE459A5DC99ED27D8ACAFB9CD9607959CCDBE46", ::end_spawn_group, undefined, undefined);
    [[var_0]]("_encstr_829517FFCBB8CFBBAD2F3B3FBFC05707D8917485C1809AE20D", 1, 2, 100, [::wave_reinforce, 1, 25], 0, "_encstr_998E1CB0E26A2551CF7BA0214FA7DE27997B40306A076F8B5795A82648CF", ::end_spawn_group, undefined, undefined);
    [[var_0]]("_encstr_A2D710A5080731FB26F83B7BA0785F1FA797", 5, 5, 5, 0.1, undefined, "_encstr_A2D710A5080731FB26F83B7BA0785F1FA797", ::end_spawn_group, undefined, undefined);
    [[var_0]]("_encstr_B6D71012A81719062E0DC0D61310EFCAC778", 6, 6, 6, 0.1, undefined, "_encstr_B6D71012A81719062E0DC0D61310EFCAC778", ::end_spawn_group, undefined, undefined);
    [[var_0]]("_encstr_B4D71036F66CAF99BEACC3334BB1EBC4FAC6", 5, 5, 5, 0.1, undefined, "_encstr_B4D71036F66CAF99BEACC3334BB1EBC4FAC6", ::end_spawn_group, "_encstr_99E91A81082ED9679F252BDCA180598FE1FF56DA3877F22117E383B9", undefined);
    [[var_0]]("_encstr_99E91A81082ED9679F252BDCA180598FE1FF56DA3877F22117E383B9", 6, 11, 0, 1, undefined, "_encstr_99E91A81082ED9679F252BDCA180598FE1FF56DA3877F22117E383B9", ::end_spawn_group, undefined, undefined);
    [[var_0]]("_encstr_ACCF0E637B36AF66D7B20F669663FAC8", 1, 1, 1, 0.1, undefined, "_encstr_ACCF0E637B36AF66D7B20F669663FAC8", undefined, "_encstr_9A48182C885147FA8F2BA37A58D1293A0EEEADD190593FF29F68", 10);
    [[var_0]]("_encstr_9A48182C885147FA8F2BA37A58D1293A0EEEADD190593FF29F68", 12, 16, undefined, [::wave_reinforce, 1, 10], 0, "_encstr_9A48182C885147FA8F2BA37A58D1293A0EEEADD190593FF29F68", ::end_spawn_group, undefined, undefined);
    [[var_0]]("_encstr_9A48182C885147FA8F2BA37A58D1293A0EEEADD190593FF29F68", 1, 2, undefined, [::wave_reinforce, 1, 10], 0, "_encstr_BD881FB1DBC6EB33AF2B3C332D1BBE64AF39594BB999ED93C656EBDC73A538AC93", ::end_spawn_group, undefined, undefined);
  }
}

wave_reinforce(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_3) && !isDefined(var_0.custom_var_done)) {
    if(isbuiltinfunction(var_3))
      [[var_3]](var_0);
    else if(isint(var_3) || isfloat(var_3))
      wait(var_3);

    var_0.custom_var_done = 1;
  }

  if(var_0.activecount <= var_0.min_size)
    return var_1;

  if(var_0.activecount >= var_0.max_size) {
    while(var_0.activecount >= var_0.min_size)
      wait 0.25;

    return var_2;
  }

  return 15;
}

reinforce_after_door_section(var_0) {
  level scripts\engine\utility::_id_143A8("_encstr_A9D506FF076BA7C2", "_encstr_BAD506B18B0B7842", "_encstr_B1D506B157477D99", "_encstr_A5D5066CEAE8BED0", "_encstr_85B71016B4D8B27DA111911E1DC36B88E818");
}

end_spawn_group(var_0) {
  level thread _end_spawn_group(var_0);
}

_end_spawn_group(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level scripts\engine\utility::_id_143A5("_encstr_9AD60EF02518379757389A8148BFCDDF", "_encstr_8DB01DF631A6AC6CD12DCEB2FA34591B2DBE91BDEE9BFAB6B41B8DBE86EC8E");
  level notify("_encstr_97010EC7E9B7736E015835FF73B0AD49" + var_0.moduleid + "_encstr_93D80BF536F6B638D8AC1D95C8");
}

show_vip_waypoints(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.escort_vip = self;
  var_1 = scripts\cp\cp_objectives::requestworldid("_encstr_951904D8F1E0", 10);
  objective_icon(var_1, "_encstr_8BCA1630FDE001233E68785FC27390AF1F75C75355799B43");
  objective_setshowdistance(var_1, 1);
  objective_setbackground(var_1, 1);
  objective_state(var_1, "_encstr_AF5A081BBAC993AC73A3");
  objective_setplayintro(var_1, 0);
  level.escort_vip.waypointobjnum = var_1;

  foreach(var_4, var_3 in var_0) {
    objective_setlocation(var_1, var_4, var_3.origin + (0, 0, 40));
    var_3 thread cleanup_waypoint_when_near(self, var_4);
  }

  scripts\engine\utility::_id_143A6("_encstr_AD75063D571AE108", "_encstr_B1DA09D3DB3FF1756059F7", "_encstr_9117168D8DAC16DCD5C17DD95A0EEB77B05E07F64BE647B9");

  foreach(var_4, var_3 in var_0)
  objective_unsetlocation(var_1, var_4);
}

cleanup_waypoint_when_near(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_B1DA09D3DB3FF1756059F7");
  var_2 = squared(750);

  for(;;) {
    var_3 = 0;

    foreach(var_5 in level.players) {
      if(distancesquared(var_5.origin, self.origin) > var_2) {
        continue;
      }
      if(sighttracepassed(var_5 getEye(), self.origin + (0, 0, 10), 0, var_5, 1))
        var_3 = 1;

      if(var_3 && sighttracepassed(var_5 getEye(), var_0.origin + (0, 0, 50), 0, var_0.attacker, 1)) {
        if(isDefined(self.attacker) && isalive(self.attacker))
          var_0 thread vip_dies_soon();
      }
    }

    if(var_3) {
      if(distancesquared(var_0.origin, self.origin) < 10000)
        var_0 playSound("_encstr_A5A3271F01C18E974357A0C2A3316DA50BDE4BC02FAB48F9677B2727FD806710AF27CF43A6FA27E61B");

      break;
    }

    wait 0.1;
  }

  objective_unsetlocation(var_0.waypointobjnum, var_1);
}

vip_dies_soon() {
  if(isDefined(self.dying_soon)) {
    return;
  }
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_990D06B916D95691");
  self.dying_soon = 1;
  var_0 = gettime() + 25000;

  if(getdvarint("_encstr_A61B0AB0A480A8E337F407A5") > 0)
    var_0 = gettime() + getdvarint("_encstr_A61B0AB0A480A8E337F407A5") * 1000;

  var_1 = squared(128);
  iprintlnbold("_encstr_AB0B2E14B158E5AC39029DB7E8011BB1DBB92B02A501E8349356B03A56DCB4B976081DF602CD34B7DE47401CB4B1B7D1");
  level thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_AF0E2326D8F7C53541A96939B469579DCBB55E25696BEDFFA5B1D9C938F3BF971B0AD537EC");
  level thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_810624081847A1BD7EDA0EBA82EF148AD5A76E31D9DE3901A687F9A8F9AB8987E88B8F8599CB");
  var_2 = gettime() + 4000;

  while(gettime() < var_0 && isDefined(self.attacker) && isalive(self.attacker)) {
    wait 0.05;

    foreach(var_4 in level.players) {
      if(abs(self.origin[2] - var_4.origin[2]) > 100) {
        continue;
      }
      if(distancesquared(self.origin, var_4.origin) < var_1) {
        level thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_AA06246828FA90A4AF9A2B25B47D3D48A4A2D02A4A2B8AA65E3584E99E15AF15094AA282A866");
        wait 2;
        self.attacker notify("_encstr_845310B7DF0260703F3CA0FB27FA9325AB6B");
        self.attacker thread scripts\cp\cp_skits::death_fight2(self);
        return;
      }
    }

    if(gettime() >= var_2) {
      level thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_AF0E2326D8F7C53541A96939B469579DCBB55E25696BEDFFA5B1D9C938F3BF971B0AD537EC");
      level thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_810624081847A1BD7EDA0EBA82EF148AD5A76E31D9DE3901A687F9A8F9AB8987E88B8F8599CB");
      var_2 = gettime() + 4000;
    }
  }

  self.attacker notify("_encstr_845310B7DF0260703F3CA0FB27FA9325AB6B");
  self.attacker thread scripts\cp\cp_skits::death_fight2(self);
}

downed_pilot_dialogue() {
  self endon("_encstr_AD75063D571AE108");

  while(!scripts\cp\utility::any_player_nearby(self.origin, 160000))
    wait 0.1;

  self playSound("_encstr_86672819F0BE361C6EF50E638EAF4E959B8D5D957D382DC6DEA3EBB473355DC95ED799DEBA7323AFC481");
  thread downed_pilot_nag();
}

downed_pilot_nag() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_84EC1422F820C3C5E897405187100FF3D573791A6385");
  self endon("_encstr_A6520CE959AA409DE713F6795BD3");

  for(;;) {
    wait(randomintrange(30, 45));
    self playSound("_encstr_AB67285D7099AF6B1327D028936763EB23DE4D5501C36310E7A3A108937A5B3D2B494CE863FA313E824A");
  }
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

init_cutout_anims() {
  level.scr_animtree["_encstr_88570E91B0D11B970A89093410A3606B"] = #animtree;
  level.scr_anim["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_8E9908980388F54F4D73"] = % _encstr_BEDA2FFA15CDD9533BC1E3F7C8D309024B2046F3850FB38CE6308BF76BA9FFFA3FCDC12AEDA15AAF4BA84F9BE081A152D5;
  level.scr_animname["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_8E9908980388F54F4D73"] = "_encstr_BEDA2FFA15CDD9533BC1E3F7C8D309024B2046F3850FB38CE6308BF76BA9FFFA3FCDC12AEDA15AAF4BA84F9BE081A152D5";
  level.scr_eventanim["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_8E9908980388F54F4D73"] = "_encstr_8FCC0CC1BA8DC6B7D5D17DB958BB";
  level.scr_anim["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_A64E08D94D2B3894AFB3"] = % _encstr_966D2F7798F39FF22960CC055E19EA6FB9D9BF97F0880DCB1F86D5BC49DBC1340328D70B40835123BB2311F22183FBFD8B;
  level.scr_animname["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_A64E08D94D2B3894AFB3"] = "_encstr_966D2F7798F39FF22960CC055E19EA6FB9D9BF97F0880DCB1F86D5BC49DBC1340328D70B40835123BB2311F22183FBFD8B";
  level.scr_eventanim["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_A64E08D94D2B3894AFB3"] = "_encstr_86A70CA30B9D2F73B84B9FBB1360";
  level.scr_anim["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_A9D506FF076BA7C2"] = % _encstr_85C0293B129BE0505A1FE9EF5B0318B46F19B163FB172D20B93A99FB7DAE218D6FC38E63D1C3E9B0C815AD;
  level.scr_animname["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_A9D506FF076BA7C2"] = "_encstr_85C0293B129BE0505A1FE9EF5B0318B46F19B163FB172D20B93A99FB7DAE218D6FC38E63D1C3E9B0C815AD";
  level.scr_eventanim["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_A9D506FF076BA7C2"] = "_encstr_ACBD0DF049519F2F9591520BF0F772";
  level.scr_anim["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_BAD506B18B0B7842"] = % _encstr_B4222957B8D3FF9249AFAC657E39CA8F59F99FF790A82D2B3FA6B59C693BE15423C8F76231E37C22ABCD3A;
  level.scr_animname["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_BAD506B18B0B7842"] = "_encstr_B4222957B8D3FF9249AFAC657E39CA8F59F99FF790A82D2B3FA6B59C693BE15423C8F76231E37C22ABCD3A";
  level.scr_eventanim["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_BAD506B18B0B7842"] = "_encstr_91BD0D38D858E5B227D7B1D51DBE64";
  level.scr_anim["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_B1D506B157477D99"] = % _encstr_A9F0296E914EEB6C83BED0BDCD8E2CCECA7DB1BA47F6EA1DAF89B1B4B5B0F523B9E8BE66BEE0C62CF2ACC9;
  level.scr_animname["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_B1D506B157477D99"] = "_encstr_A9F0296E914EEB6C83BED0BDCD8E2CCECA7DB1BA47F6EA1DAF89B1B4B5B0F523B9E8BE66BEE0C62CF2ACC9";
  level.scr_eventanim["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_B1D506B157477D99"] = "_encstr_8FBD0D0B80BFF74F889F4B45D1B982";
  level.scr_anim["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_A5D5066CEAE8BED0"] = % _encstr_9391299EF0130F4830D6089013A5F7FFB5B0DF1DA14743EBE7F9C1C4899337F88B6B5F7B2F6B982F5B5F22;
  level.scr_animname["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_A5D5066CEAE8BED0"] = "_encstr_9391299EF0130F4830D6089013A5F7FFB5B0DF1DA14743EBE7F9C1C4899337F88B6B5F7B2F6B982F5B5F22";
  level.scr_eventanim["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_A5D5066CEAE8BED0"] = "_encstr_82BD0DEBFD89205DD387C7E3C3E93D";
  level.scr_anim["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_AD6513C88473F1CACF1B4B29BBB1610AFBC8DC9B51"] = % _encstr_87FD2810727179407FCC0F74B5A7EB2326BAB0A8C9D6B9583FC1857D9BD353E70822B049D3EDDB12F7FA;
  level.scr_animname["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_AD6513C88473F1CACF1B4B29BBB1610AFBC8DC9B51"] = "_encstr_87FD2810727179407FCC0F74B5A7EB2326BAB0A8C9D6B9583FC1857D9BD353E70822B049D3EDDB12F7FA";
  level.scr_eventanim["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_AD6513C88473F1CACF1B4B29BBB1610AFBC8DC9B51"] = "_encstr_AD6513C88473F1CACF1B4B29BBB1610AFBC8DC9B51";
  level.scr_animtree["_encstr_BD1904CB7BBB"] = #animtree;
  level.scr_anim["_encstr_BD1904CB7BBB"]["_encstr_8E9908980388F54F4D73"] = % _encstr_87732CCDC8E4EB6CE0FAA1DBCD3A58B359D7B1EAA3B7AE47FA89632DB6C2EB32E61DAF83BAC663F6AE3AD79B16EE;
  level.scr_animname["_encstr_BD1904CB7BBB"]["_encstr_8E9908980388F54F4D73"] = "_encstr_87732CCDC8E4EB6CE0FAA1DBCD3A58B359D7B1EAA3B7AE47FA89632DB6C2EB32E61DAF83BAC663F6AE3AD79B16EE";
  level.scr_anim["_encstr_BD1904CB7BBB"]["_encstr_A64E08D94D2B3894AFB3"] = % _encstr_99ED2C1383632FE673D0A9C2A019A0E8A1D75FE7E3E04F7B20FD0C4B29C91154EBCCC7E8A585D76FB3B01760467B;
  level.scr_animname["_encstr_BD1904CB7BBB"]["_encstr_A64E08D94D2B3894AFB3"] = "_encstr_99ED2C1383632FE673D0A9C2A019A0E8A1D75FE7E3E04F7B20FD0C4B29C91154EBCCC7E8A585D76FB3B01760467B";
  level.scr_anim["_encstr_BD1904CB7BBB"]["_encstr_A9D506FF076BA7C2"] = % _encstr_A566268F7D7E3E136F20D0B8AACB689C1B0FD6F37B521BF1417AA5E35AFA0F33D63B51891F63D1C3;
  level.scr_animname["_encstr_BD1904CB7BBB"]["_encstr_A9D506FF076BA7C2"] = "_encstr_A566268F7D7E3E136F20D0B8AACB689C1B0FD6F37B521BF1417AA5E35AFA0F33D63B51891F63D1C3";
  level.scr_anim["_encstr_BD1904CB7BBB"]["_encstr_BAD506B18B0B7842"] = % _encstr_92A0261F44A32148CBE7E01A6350C71115D9CF2B432F556BD1FBC5C7AAD14FD5C0382177B74B0EB3;
  level.scr_animname["_encstr_BD1904CB7BBB"]["_encstr_BAD506B18B0B7842"] = "_encstr_92A0261F44A32148CBE7E01A6350C71115D9CF2B432F556BD1FBC5C7AAD14FD5C0382177B74B0EB3";
  level.scr_anim["_encstr_BD1904CB7BBB"]["_encstr_B1D506B157477D99"] = % _encstr_85752676D7EB77A9B0C7F0D06FECA14F22B1E6FD2BD2FB73B75BD8E83F11BEF12BE37026494B9BDB;
  level.scr_animname["_encstr_BD1904CB7BBB"]["_encstr_B1D506B157477D99"] = "_encstr_85752676D7EB77A9B0C7F0D06FECA14F22B1E6FD2BD2FB73B75BD8E83F11BEF12BE37026494B9BDB";
  level.scr_anim["_encstr_BD1904CB7BBB"]["_encstr_A5D5066CEAE8BED0"] = % _encstr_935D269B1927D76C1CFA34ED6E1D85CE95AFB1AB1DDBABE8BE31D84BB5B0FA466E1DD743EB6EC277;
  level.scr_animname["_encstr_BD1904CB7BBB"]["_encstr_A5D5066CEAE8BED0"] = "_encstr_935D269B1927D76C1CFA34ED6E1D85CE95AFB1AB1DDBABE8BE31D84BB5B0FA466E1DD743EB6EC277";
  level.scr_animtree["_encstr_B1190448CD80"] = #animtree;
  level.scr_anim["_encstr_B1190448CD80"]["_encstr_A21C0D36ED6C5B83D2E8F5B4238DCA"] = % _encstr_AFC8305BE1560FAEF83FE0FF7FA3F627753EE36269A2FF22A9ADECF16BC0FF97A6B37B8AB20D73D1609914C5777044FBC02B;
  level.scr_animname["_encstr_B1190448CD80"]["_encstr_A21C0D36ED6C5B83D2E8F5B4238DCA"] = "_encstr_AFC8305BE1560FAEF83FE0FF7FA3F627753EE36269A2FF22A9ADECF16BC0FF97A6B37B8AB20D73D1609914C5777044FBC02B";
  level.scr_animname["_encstr_B1190448CD80"]["_encstr_AFE00FC67B1B6DE0D21DBE83961BAD571C"] = "_encstr_85492BDC234E7DD807FA0DB79BD1B03B95BE1CA5C6B65DC1FA98D82D5B2C91CA371D27ED5EB223F50EB4C6ED3A";
  level.scr_anim["_encstr_B1190448CD80"]["_encstr_AFE00FC67B1B6DE0D21DBE83961BAD571C"] = % _encstr_85492BDC234E7DD807FA0DB79BD1B03B95BE1CA5C6B65DC1FA98D82D5B2C91CA371D27ED5EB223F50EB4C6ED3A;
  level.scr_animtree["_encstr_BAB607298EEB09D45F"] = #animtree;
  level.scr_anim["_encstr_BAB607298EEB09D45F"]["_encstr_BA1C12936F270CD34B6B3F1BC9134A08506F5BF7"] = % _encstr_B2CF27A5B029F8F7465C13DCBF29A86CE7EA0B48BEE279B01F870983CA135628832233618BF1C3EF7B;
  level.scr_animname["_encstr_BAB607298EEB09D45F"]["_encstr_BA1C12936F270CD34B6B3F1BC9134A08506F5BF7"] = "_encstr_B2CF27A5B029F8F7465C13DCBF29A86CE7EA0B48BEE279B01F870983CA135628832233618BF1C3EF7B";
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

init_exfil_anims() {
  level.scr_animtree["_encstr_95DC110B1D69C0BD3367CDFBF3C97630093551"] = #animtree;
  level.scr_anim["_encstr_95DC110B1D69C0BD3367CDFBF3C97630093551"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"] = % _encstr_BA312256FBD93C9796BB2A32E1F8F3F27B69F7CE75314643B3B022B9E8D05BADD8037542;
  level.scr_animname["_encstr_95DC110B1D69C0BD3367CDFBF3C97630093551"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"] = "_encstr_BA312256FBD93C9796BB2A32E1F8F3F27B69F7CE75314643B3B022B9ECD05BADD8037542";
  level.scr_eventanim["_encstr_95DC110B1D69C0BD3367CDFBF3C97630093551"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"] = "_encstr_BE8816F0BD783E30FDA8A3C70104E3F00B91593BFA83FFFC";
  level.scr_anim["_encstr_95DC110B1D69C0BD3367CDFBF3C97630093551"]["_encstr_ACD10D136396B62CD7324EF607FA93"] = % _encstr_A7BD22D3D80FB417CBA5F9F73596E3FA87C8CA4A28B76E53E001C1D756BEFB05C3289283;
  level.scr_animname["_encstr_95DC110B1D69C0BD3367CDFBF3C97630093551"]["_encstr_ACD10D136396B62CD7324EF607FA93"] = "_encstr_A7BD22D3D80FB417CBA5F9F73596E3FA87C8CA4A28B76E53E001C1D746BEFB05C3289283";
  level.scr_eventanim["_encstr_95DC110B1D69C0BD3367CDFBF3C97630093551"]["_encstr_ACD10D136396B62CD7324EF607FA93"] = "_encstr_A988164002982D260BB1E748924B28CB46D918D8AA723FDB";
  level.scr_animtree["_encstr_B1190448CD80"] = #animtree;
  level.scr_anim["_encstr_B1190448CD80"]["_encstr_ACD10D136396B62CD7324EF607FA93"] = % _encstr_86D4252B5F3AB1FE5327B1B7BF3B37A8C5793183058078244A3F9DA92F720F218AC13B786DF718;
  level.scr_animname["_encstr_B1190448CD80"]["_encstr_ACD10D136396B62CD7324EF607FA93"] = "_encstr_86D4252B5F3AB1FE5327B1B7BF3B37A8C5793183058078244A3F9DA92F720F21AAC13B786DF718";
  level.scr_anim["_encstr_B1190448CD80"]["_encstr_B4AF1226C6D2AD85BEC8E4DB0EBE27EB9623B1CA"] = % _encstr_81F230AF61AAD7271A191BD7FF61F2B7A55161E8B8100782B931994C9A38E9899BA843B94DC56FA7E36B739F8E63A8997020;
  level.scr_animname["_encstr_B1190448CD80"]["_encstr_B4AF1226C6D2AD85BEC8E4DB0EBE27EB9623B1CA"] = "_encstr_81F230AF61AAD7271A191BD7FF61F2B7A55161E8B8100782B931994C9A38E9891BA843B94DC56FA7E36B739F8E63A8997020";
  level.scr_anim["_encstr_B1190448CD80"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"] = % _encstr_B49E2576D7EB77A9B0C7F0D06FECA14F22B1657EED23CF318EAFA8C02F1D7987DA29E70B858AB1;
  level.scr_animname["_encstr_B1190448CD80"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"] = "_encstr_B49E2576D7EB77A9B0C7F0D06FECA14F22B1657EED23CF318EAFA8C02F1D7987D829E70B858AB1";
  level.scr_anim["_encstr_B1190448CD80"]["_encstr_B22A1230E27CF3014F5C06F02027E8CF24CAF880"] = % _encstr_B2743083E5828FFF936178E713439BEF6269881B1F1777E111C908904340B867E4BEA02C3161A668CDDBD338417BC02D5FAB;
  level.scr_animname["_encstr_B1190448CD80"]["_encstr_B22A1230E27CF3014F5C06F02027E8CF24CAF880"] = "_encstr_B2743083E5828FFF936178E713439BEF6269881B1F1777E111C908904340B867C4BEA02C3161A668CDDBD338417BC02D5FAB";
  level.scr_animtree["_encstr_BD9E0EA7DBEA038131D343F0A34890C0"] = #animtree;
  level.scr_anim["_encstr_BD9E0EA7DBEA038131D343F0A34890C0"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"] = % _encstr_8D2425CDC8C9AFC6E0F5A1BDE6E82CD9CAEBC8E47B07F66633BE4CC65AB616AFC6AF1336B46B85;
  level.scr_animname["_encstr_BD9E0EA7DBEA038131D343F0A34890C0"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"] = "_encstr_8D2425CDC8C9AFC6E0F5A1BDE6E82CD9CAEBC8E47B07F66633BE4CC65AB616AFC4AF1336B46B85";
  level.scr_anim["_encstr_BD9E0EA7DBEA038131D343F0A34890C0"]["_encstr_ACD10D136396B62CD7324EF607FA93"] = % _encstr_82192596370B974950675070CF8CC12F8211859E4D83AF912E4F08604FBD99275B890E29A40A7B;
  level.scr_animname["_encstr_BD9E0EA7DBEA038131D343F0A34890C0"]["_encstr_ACD10D136396B62CD7324EF607FA93"] = "_encstr_82192596370B974950675070CF8CC12F8211859E4D83AF912E4F08604FBD992759890E29A40A7B";
  level.scr_animtree["_encstr_B6F40B8D18B3B74D9970991A8A"] = #animtree;
  level.scr_anim["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"] = % _encstr_8614243B49A3BFCFC88713C79ABB71977FE9ECC2A20708A7A477C56189E726F07CF761ED24B3;
  level.scr_animname["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"] = "_encstr_8614243B49A3BFCFC88713C79ABB71977FE9ECC2A20708A7A477C56189E726F05CF761ED24B3";
  level.scr_anim["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_852E15EA4C97655A0F384EBF5AAF0CA7B21520B50F738E"] = % _encstr_85642F425FB2E063F2AFC810F3198F91B7575943625240C3777722DD730B216760BF8A2DF0CD3EE7752CF308AE2F1AD142;
  level.scr_animname["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_852E15EA4C97655A0F384EBF5AAF0CA7B21520B50F738E"] = "_encstr_85642F425FB2E063F2AFC810F3198F91B7575943625240C3777722DD730B216764BF8A2DF0CD3EE7752CF308AE2F1AD142";
  level.scr_anim["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_960B16A0B082C1EA4E324B38018EF967E3ED7A45764AC8BB"] = % _encstr_A20D2FF7F10EC153A8CE04CD63A0999A6D6F537B7FB78A0E60D6BE15D8B0A151B1D7EFBBD15531CFD0DBB2DD36B8E49A93;
  level.scr_animname["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_960B16A0B082C1EA4E324B38018EF967E3ED7A45764AC8BB"] = "_encstr_A20D2FF7F10EC153A8CE04CD63A0999A6D6F537B7FB78A0E60D6BE15D8B0A151A1D7EFBBD15531CFD0DBB2DD36B8E49A93";
  level.scr_anim["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_ACD10D136396B62CD7324EF607FA93"] = % _encstr_B43F24C29188472237B7A34717DDCAB7E85EBF0A68F00F2A049F83430B09B2D7F8A6761560CB;
  level.scr_animname["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_ACD10D136396B62CD7324EF607FA93"] = "_encstr_B43F24C29188472237B7A34717DDCAB7E85EBF0A68F00F2A049F83430B09B2D7F9A6761560CB";
  level.scr_anim["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_86CD150808DF9A4329B9AAF5F3878DE73127420A603370"] = % _encstr_BA302F53E9B0F1A717DEBAB2236DE7B75037FCDA6748056B34F6128A48C91F61404F79548958411FE88B0BA2961763E5E0;
  level.scr_animname["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_86CD150808DF9A4329B9AAF5F3878DE73127420A603370"] = "_encstr_BA302F53E9B0F1A717DEBAB2236DE7B75037FCDA6748056B34F6128A48C91F61414F79548958411FE88B0BA2961763E5E0";
  level.scr_anim["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_9ADD1626D82DB6C2AF4627ED83EB27AFB4238D59F5BD5D3A"] = % _encstr_95EA2F6E29138F3981C7C92FBE532781174E58CB60320294F9B72ACD4B45D889E2E744E91495F820132D7618E85199C068;
  level.scr_animname["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_9ADD1626D82DB6C2AF4627ED83EB27AFB4238D59F5BD5D3A"] = "_encstr_95EA2F6E29138F3981C7C92FBE532781174E58CB60320294F9B72ACD4B45D889C2E744E91495F820132D7618E85199C068";
}

idle_pilot_loop(var_0) {
  var_0 endon("_encstr_A60A075AC355CF2BD8");
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;)
    scripts\common\anim::anim_single_solo(var_0.body, "_encstr_A21C0D36ED6C5B83D2E8F5B4238DCA", "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
}

cut_objective_progress(var_0, var_1) {
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(self.cut_progress))
    self.cut_progress = 0;

  while(self.cut_progress <= var_1 && var_0 useButtonPressed()) {
    objective_setprogress(self.cut_progress, var_1);
    wait 0.05;
    self.cut_progress = self.cut_progress + 0.05;
  }

  return self.cut_progress >= var_1;
}

wait_for_pilot_pickup(var_0) {
  if(!isDefined(var_0.interaction_handle)) {
    var_0.interaction_handle = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.body gettagorigin("_encstr_9ABB0968F1402B19E2AFA9"));
    var_0.interaction_handle linkTo(var_0);
  }

  var_0.pickup_disabled = 0;
  var_0.interaction_handle makeusable();
  var_0.interaction_handle setHintString(&"_encstr_A12420E1F929854F7743BB36634FD4CDC4306921943333A75EBBA50D1F1B5C097D89");
  var_0.interaction_handle sethintonobstruction("_encstr_BD1805CB69C063");
  var_0.interaction_handle setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_0.interaction_handle sethintdisplayrange(160);
  var_0.interaction_handle sethintdisplayfov(80);
  var_0.carryobjectasset = "_encstr_967F0E0D8D02F91B1C19F113C32050CB";
  var_0.idleanim = "_encstr_BABF29E6919CFA6C07FA1ABDB9A3C2CECAFA8C4EDBC1B799CCFA3B27EDBA7332BE4B9136ACEB0E9636B71D";
  level.hostage_onusefunc = ::pilot_pickup_from_cockpit;
  var_0.interaction_handle waittill("_encstr_8F5C086405E70FBA4B4A", var_1);
  var_0 scripts\cp\cp_pickup_hostage::hostage_onuse(var_1, "_encstr_B6CC0586B28D96", self);
  var_0.interaction_handle delete();
  var_0.interaction_handle = undefined;
}

#using_animtree("_encstr_B40101");

pilot_pickup_from_cockpit(var_0, var_1) {
  var_1 notify("_encstr_A60A075AC355CF2BD8");
  var_1.drophintstring = "_encstr_ADD813912A8DD0E08BD2B0D86B5F23702284231FA5";
  var_1.pickuphintstring = &"_encstr_B1EF21FF41C1CD111FE9AB1D50819CF6BD3329137406F5271008AB342870B95767DD3F";
  var_1.interaction_handle makeunusable();
  var_0.restoreweapon = var_0 getcurrentweapon();
  var_2 = getcompleteweaponname("_encstr_9A0D0C4B54606F8F63C84B8B53EE");
  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_2, undefined, undefined, 1);
  var_3 = var_0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_2, 0);
  var_0.gunlessweapon = var_2;
  var_0 scripts\common\utility::allow_weapon_switch(0);
  var_4 = getstartorigin(self.origin, self.angles, level.scr_anim["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_AD6513C88473F1CACF1B4B29BBB1610AFBC8DC9B51"]);
  var_5 = getstartangles(self.origin, self.angles, level.scr_anim["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_AD6513C88473F1CACF1B4B29BBB1610AFBC8DC9B51"]);
  var_0 freezecontrols(1);
  var_0 setstance("_encstr_A5AD069B231F0BAF");
  var_0 scripts\engine\utility::_id_143B9(1, "_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  var_0 thread scripts\cp\cp_pickup_hostage::create_player_rig(var_0, "_encstr_88570E91B0D11B970A89093410A3606B");
  scripts\common\anim::anim_first_frame_solo(var_0.player_rig, "_encstr_AD6513C88473F1CACF1B4B29BBB1610AFBC8DC9B51");
  scripts\cp\cp_pickup_hostage::link_player_to_rig(var_0, 0.5);
  var_0.vmvip = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
  var_0.vmvip.angles = var_1.angles;
  var_0.vmvip setModel(var_1.body.model);
  var_0.vmvip.animname = "_encstr_BAB607298EEB09D45F";
  var_0.vmvip useanimtree(level.scr_animtree["_encstr_BAB607298EEB09D45F"]);
  var_0.vmvip hide();
  var_0.vmvip showtoplayer(var_0);
  var_1 hidefromplayer(var_0);

  if(isDefined(var_1.head))
    var_1.head hidefromplayer(var_0);

  thread scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, "_encstr_AD6513C88473F1CACF1B4B29BBB1610AFBC8DC9B51");
  thread scripts\common\anim::anim_single_solo(var_1.body, "_encstr_AFE00FC67B1B6DE0D21DBE83961BAD571C");
  thread scripts\common\anim::anim_single_solo(var_0.vmvip, "_encstr_BA1C12936F270CD34B6B3F1BC9134A08506F5BF7");
  self scriptmodelplayanim("_encstr_B85B2A9D6BD70DBDCD8E0B76B2BE1CB48DD6BA0ED74CB14B6B8532ACE61D93DECB2B46F5131B966B2C196E47");
  self scriptmodelplayanim("_encstr_8D1A2E6E91C9D7B1387DD07BE61D2CB32BEB384B8D5BD5C1EB26B15AB6C28CAC6E1DC97B97B28CEB13D8A55B1646CD3A");
  var_6 = getanimlength(%_encstr_87FD2810727179407FCC0F74B5A7EB2326BAB0A8C9D6B9583FC1857D9BD353E70822B049D3EDDB12F7FA);
  wait(var_6 + 0.1);
  var_1 linkTo(var_0);
  var_1.body hide();
  var_0.vmvip delete();
  var_7 = scripts\cp\cp_pickup_hostage::run_stealth_funcs(var_0);
  var_0 setOrigin(var_7);
  waitframe();
  var_0 notify("_encstr_BE840BF2FFD8B0A4DB6EE31FA1");
  var_0 freezecontrols(0);
}

create_long_cut_interactions(var_0, var_1, var_2) {
  var_3 = anglesToForward((0, var_0.angles[1], 0));
  var_4 = anglestoleft((0, var_0.angles[1], 0));
  var_5 = var_0.origin;
  var_6 = var_5 + var_3 * 125 + var_4 * 72 + (0, 0, 50);
  var_7 = create_long_cut_interaction(var_6, &"_encstr_860124F779164221B7A6408A828FC80A1C497FD3D96FFDF9BF565B3390F9E0DC446997373904", ["_encstr_B1D506B157477D99", "_encstr_A5D5066CEAE8BED0"], var_1, var_0, var_2);
  level.cut_interactions = [var_7];

  foreach(var_9 in level.cut_interactions) {
    if(isDefined(var_9))
      var_9 makeusable();
  }
}

create_long_cut_interaction(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_6 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  waitframe();
  var_6 setHintString(var_1);
  var_6 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_6 sethintdisplayrange(200);
  var_6 sethintdisplayfov(65);
  var_6 setuserange(72);
  var_6 setusefov(65);
  var_6 sethintonobstruction("_encstr_BD1805CB69C063");
  var_6 setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");
  var_6.targetname = "_encstr_951514DB7E4ACE1FCF3AF79CBB9B0752A71E4990BAC8";

  foreach(var_8 in var_2) {
    if(!scripts\engine\utility::flag_exist(var_8))
      scripts\engine\utility::flag_init(var_8);
  }

  var_6 thread use_think_long_cut(var_2, var_3, var_4, var_5);
  return var_6;
}

use_think_long_cut(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(isDefined(level.cut_interactions)) {
      foreach(var_5 in level.cut_interactions) {
        if(isDefined(var_5))
          var_5 makeusable();
      }
    }

    self waittill("_encstr_8F5C086405E70FBA4B4A", var_7);
    level notify("_encstr_85B71016B4D8B27DA111911E1DC36B88E818");

    if(isDefined(var_7)) {
      if(!var_7 scripts\cp\utility::is_valid_player()) {
        continue;
      }
      foreach(var_5 in level.cut_interactions) {
        if(isDefined(var_5))
          var_5 makeunusable();
      }

      if(!var_2 cutout_pilot_long(var_1, var_7, var_0, var_3)) {
        wait 1;
        continue;
      }
    }

    foreach(var_11 in var_0) {
      if(scripts\engine\utility::flag_exist(var_11))
        scripts\engine\utility::flag_set(var_11);
    }

    if(isDefined(level.cut_interactions)) {
      foreach(var_5 in level.cut_interactions) {
        if(isDefined(var_5))
          var_5 makeusable();
      }
    }

    self delete();
  }
}

cutout_pilot_long(var_0, var_1, var_2, var_3) {
  var_0 makeunusable();
  var_4 = getcompleteweaponname("_encstr_962A124B7707BE76EADC1B566EDCFA5A3799A5C6");
  var_1 scripts\cp\utility::_giveweapon(var_4, undefined, undefined, 1);
  var_5 = var_1 scripts\cp\cp_weapons::switchtoweaponreliable(var_4, 0);
  var_1 scripts\common\utility::allow_weapon_switch(0);
  var_1._id_140AE = 1;
  var_6 = getstartorigin(self.origin, self.angles, level.scr_anim["_encstr_88570E91B0D11B970A89093410A3606B"][var_2[0]]);
  var_7 = getstartangles(self.origin, self.angles, level.scr_anim["_encstr_88570E91B0D11B970A89093410A3606B"][var_2[0]]);
  var_1 setOrigin(var_6, 1);
  var_1 setplayerangles(var_7);
  var_1 setstance("_encstr_A5AD069B231F0BAF");
  var_8 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_8 setModel("_encstr_B4091F2377E74127FBCF9A5DE3B2F485E9120E90A0AB75B0E39958E1DAF1B6E06B");
  var_8.angles = self.angles;
  var_8.animname = "_encstr_BD1904CB7BBB";
  var_8 hide();
  var_1 forceusehinton(&"_encstr_A6A61F6828FA12A4FA9A2B2596AF3D09298A1A8AA46551A99734AA15EB8452E48A");
  var_8 useanimtree(level.scr_animtree["_encstr_BD1904CB7BBB"]);
  var_1 thread scripts\cp\cp_destruction::create_player_rig(var_1, "_encstr_88570E91B0D11B970A89093410A3606B");
  var_1 cameraset("_encstr_ADF219108F65A9E5EA215E5D02931710EF1F9390D714A65DD1D6CF");
  objective_addclienttomask(var_3.objectiveindex, var_1);
  objective_hidefromplayersinmask(var_3.objectiveindex);
  var_5 = wait_for_section_cut_long(var_1, var_8, var_2);

  if(!istrue(var_5))
    var_1 notify("_encstr_83F70B36AEA3D7CC8596362B8C");

  var_1 cameradefault();
  objective_removeclientfrommask(var_3.objectiveindex, var_1);
  var_1 forceusehintoff();
  var_8 delete();
  scripts\cp\cp_destruction::remove_player_rig(var_1);
  var_1 scripts\common\utility::allow_weapon_switch(1);
  var_1 scripts\cp\cp_weapons::_takeweapon(var_4);
  var_1 scripts\cp\cp_weapons::forcevalidweapon();
  var_1 setstance("_encstr_A5AD069B231F0BAF");
  var_1._id_140AE = undefined;

  if(istrue(var_5)) {
    level notify("_encstr_8A631A36BA47EDBA3AFA07A51BF647D71B7B7376D76ED56CB12BB96E");
    return 1;
  }

  return 0;
}

wait_for_section_cut_long(var_0, var_1, var_2) {
  if(!isDefined(self.cut_progress))
    self.cut_progress = 0;

  var_3 = getanimlength(level.scr_anim["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_8E9908980388F54F4D73"]);
  var_4 = getanimlength(level.scr_anim["_encstr_88570E91B0D11B970A89093410A3606B"][var_2[0]]);
  var_5 = getanimlength(level.scr_anim["_encstr_88570E91B0D11B970A89093410A3606B"][var_2[1]]);
  var_6 = getanimlength(level.scr_anim["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_A64E08D94D2B3894AFB3"]);
  thread scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, "_encstr_8E9908980388F54F4D73");
  thread scripts\common\anim::anim_single_solo(var_1, "_encstr_8E9908980388F54F4D73");
  wait 0.25;
  var_1 show();
  wait 0.25;
  var_1 playLoopSound("_encstr_BDE50BF38A47380892E15D9370");
  wait(var_3 - 0.25);
  var_7 = var_4 + var_5;

  if(isDefined(level.helidown_long_cut_len))
    var_7 = level.helidown_long_cut_len;

  thread do_cut_anims_long(var_0, var_1, var_2);
  cut_progress_think(var_0, var_7);
  var_0 notify("_encstr_841C096CBA3AD723B73795");
  var_0 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", 0);
  var_0 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);
  var_1 stoploopsound();
  playsoundatpos(var_1.origin, "_encstr_846C106E85DDBEE60E5ACD570E7D6E3AB738");
  wait 0.5;

  if(!scripts\cp\cp_laststand::player_in_laststand(var_0)) {
    thread scripts\common\anim::anim_single_solo(var_1, "_encstr_A64E08D94D2B3894AFB3");
    scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, "_encstr_A64E08D94D2B3894AFB3");
  }

  var_1 hide();
  return self.cut_progress >= var_7;
}

do_cut_anims_long(var_0, var_1, var_2) {
  var_0 endon("_encstr_83F70B36AEA3D7CC8596362B8C");
  var_0 endon("_encstr_841C096CBA3AD723B73795");
  var_3 = getanimlength(level.scr_anim["_encstr_88570E91B0D11B970A89093410A3606B"][var_2[0]]);
  var_4 = getanimlength(level.scr_anim["_encstr_88570E91B0D11B970A89093410A3606B"][var_2[1]]);
  thread scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, var_2[0]);
  thread scripts\common\anim::anim_single_solo(var_1, var_2[0]);
  wait 0.5;
  var_1 setscriptablepartstate("_encstr_84AC07D798315292CF", "_encstr_AB0703DBB9");
  wait(var_3);
  thread scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, var_2[1]);
  thread scripts\common\anim::anim_single_solo(var_1, var_2[1]);
  wait(var_4);
}

cut_progress_think(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 11);

  for(var_0.hasprogressbar = 1; var_0 scripts\cp_mp\utility\player_utility::_isalive() && var_0 scripts\cp\utility::is_valid_player() && var_0 useButtonPressed() && self.cut_progress < var_1; self.cut_progress = self.cut_progress + 0.05) {
    level notify("_encstr_B6CF1F36BA8EF6ABD1BE1CD236DBD1F53893BDEC392B9BDCEB6693C28DD1D27B37", self.cut_progress / var_1);
    var_0 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", self.cut_progress / var_1);
    wait 0.05;
  }
}

exfil_players_on_rescue_fail() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8FA60E511772B7189F5A61BB069DD8CD");
  level waittill("_encstr_8DB01DF631A6AC6CD12DCEB2FA34591B2DBE91BDEE9BFAB6B41B8DBE86EC8E");
  level thread scripts\cp\infilexfil\blima_exfil::listen_for_exfil();
  level notify("_encstr_91750BE60B41C076B37326D770", (0, 0, 0));
}