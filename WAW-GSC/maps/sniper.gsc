/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\sniper.gsc
*****************************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_anim;
#include maps\_vehicle;
#include maps\sniper_stealth_logic;
#include maps\_music;

main() {
    setVolFog(759.379, 4196, 276, 358.969, 0.49, 0.56, 0.6, 0.0);
    maps\_panzeriv::main("vehicle_ger_tracked_panzer4v1", "panzeriv", false);
    maps\_jeep::main("vehicle_ger_wheeled_horch1a_backseat");
    maps\_halftrack::main("vehicle_ger_tracked_halftrack", undefined, false);
    maps\_truck::main("vehicle_ger_wheeled_opel_blitz", "opel");
    maps\sniper_fx::main();
    precacheshellshock("sniper_intro");
    precacheshellshock("sniper_water");
    precacheshellshock("level_end");
    precacheshellshock("tankblast");
    precacheshellshock("aftermath");
    precacheshellshock("frag_grenade_mp");
    precachemodel("char_rus_guard_ushankaup1");
    precachemodel("vehicle_ger_air_condor");
    precachemodel("vehicle_ger_tracked_halftrack");
    precachemodel("vehicle_ger_wheeled_opel_blitz");
    precachemodel("weapon_rus_ppsh_smg");
    PrecacheModel("tag_origin_animate");
    precachemodel("tag_origin");
    precacheitem("ppsh");
    precacheitem("molotov");
    precacheitem("napalmblob");
    precacheItem("napalmbloblight");
    precacheitem("mosin_rifle_scoped");
    precacheitem("mosin_rifle_scoped_noflash");
    PrecacheModel("weapon_rus_mosinnagant_scoped_rifle");
    PrecacheModel("anm_okinawa_cigarette_jpn");
    PrecacheModel("anim_berlin_mannequin");
    PrecacheModel("anim_berlin_mannequin_d");
    precachemodel("anim_sniper_beam_fall");
    precachemodel("viewmodel_rus_guard_player");
    precachemodel("anim_sniper_bookshelf_fall");
    precachemodel("anim_sniper_ceiling_fall2");
    precachemodel("anim_sniper_ceiling_fall3");
    precachemodel("anim_berlin_crow");
    precachemodel("anim_sniper_chandelier_fall");
    precachemodel("anim_berlin_chandelier01");
    precachemodel("anim_sniper_pipe_bust");
    precachemodel("anim_berlin_curtain_beige_d");
    precachemodel("viewmodel_rus_guardsinged_arms");
    precachemodel("viewmodel_rus_guardsinged_player");
    precacherumble("tank_rumble");
    precacherumble("explosion_generic");
    precacherumble("damage_light");
    stringrefs();
    default_start(maps\sniper_event1::event1_start);
    add_start("event1b", maps\sniper_event1::event1_shooting_start, & "STARTS_SNIPER_EVENT1B");
    add_start("event1c", maps\sniper_event1::event1_moveup_start, & "STARTS_SNIPER_EVENT1C");
    add_start("event1d", maps\sniper_event1::event1d_start, & "STARTS_SNIPER_EVENT1D");
    add_start("event2", maps\sniper_event2::event2_start, & "STARTS_SNIPER_EVENT2");
    add_start("event2b", maps\sniper_event2::event2b_start, & "STARTS_SNIPER_EVENT2B");
    add_start("event2c", maps\sniper_event2::event2c_start, & "STARTS_SNIPER_EVENT2C");
    add_start("event2d", maps\sniper_event2::event2d_start, & "STARTS_SNIPER_EVENT2D");
    add_start("event2e", maps\sniper_event2::event2e_start, & "STARTS_SNIPER_EVENT2E");
    add_start("event3", maps\sniper_event3::event3_start, & "STARTS_SNIPER_EVENT3");
    add_start("event3b", maps\sniper_event3::event3b_start, & "STARTS_SNIPER_EVENT3B");
    add_start("event3c", maps\sniper_event3::event3c_start, & "STARTS_SNIPER_EVENT3C");
    add_start("event4", maps\sniper_event4::event4_start, & "STARTS_SNIPER_EVENT4");
    add_start("event5", maps\sniper_event4::event5_skipto, & "STARTS_SNIPER_EVENT5");
    animscripts\dog_init::initDogAnimations();
    maps\sniper_anim::drone_custom_run_cycles();
    maps\_drones::init();
    level.drone_spawnFunction["axis"] = character\char_ger_wrmcht_k98::main;
    level.campaign = "russian";
    maps\_load::main();
    level.e1_timing_feedback = "excellent_aim";
    level.e1_timing_feedback_time = 4;
    maps\sniper_anim::main();
    maps\_mganim::main();
    sniper_stealth_main();
    maps\sniper_amb::main();
    level thread init_flags();
    level thread trig_and_flag_setup();
    switch (getdifficulty()) {
      case "easy":
        level.difficulty = 1;
        break;
      case "medium":
        level.difficulty = 2;
        break;
      case "hard":
        level.difficulty = 3;
        break;
      case "fu":
        level.difficulty = 4;
        break;
    }
    maps\sniper_ai_spawnfuncs::setup_spawn_functions();
    wait_for_first_player();
    get_players()[0] FreezeControls(true);
    level.hero = getent("sniper_hero", "script_noteworthy");
    level.hero thread hero_setup();
    level.default_goalradius = 32;
    level.explodernum = 0;
    level.linequeue = [];
    level.linequeue2 = [];
    level.animfudgetime = 0.05;
    level.hero_run_anim = "e1_street_run";
    createthreatbiasgroup("russian_squad");
    createthreatbiasgroup("badguys");
    createthreatbiasgroup("ignoreplayer");
    createthreatbiasgroup("hero");
    createthreatbiasgroup("player");
    createthreatbiasgroup("flankers");
    createthreatbiasgroup("newbhater");
    createthreatbiasgroup("newbs");
    /
    tp_to_start(eventname) {
      level.hero = getent("sniper_hero", "script_noteworthy");
      level.hero allowedstances("stand", "crouch", "prone");
      players = get_players();
      event3_players_start = getstructarray(eventname + "_playerstart", "targetname");
      for (i = 0; i < players.size; i++) {
        players[i] setOrigin(event3_players_start[i].origin + (0, 0, -10000));
        players[i] setplayerangles(event3_players_start[i].angles);
      }
      wait 0.1;
      hero_start_spot = getstruct(eventname + "_herostart", "targetname");
      level.hero teleport(hero_start_spot.origin, hero_start_spot.angles);
      wait 0.1;
      for (i = 0; i < players.size; i++) {
        players[i] setOrigin(event3_players_start[i].origin);
        players[i] setplayerangles(event3_players_start[i].angles);
      }
      VisionSetNaked("Sniper_default", 1);
      get_players()[0] giveweapon("mosin_rifle_scoped");
      get_players()[0] SwitchToWeapon("mosin_rifle_scoped");
      guys = getentarray("wounded_fountain_guys", "script_noteworthy");
      for (i = 0; i < guys.size; i++) {
        guys[i] delete();
      }
    }
    guys_to_nodes(guys, nodes) {
      nodecounter = 0;
      for (i = 0; i < guys.size; i++) {
        if(isDefined(nodes[nodecounter])) {
          guys[i] thread ignore_and_run(nodes[nodecounter]);
          nodecounter++;
        }
      }
    }
    getsquad() {
      squad = getaiarray("allies");
      squad = array_remove(squad, level.hero);
      return squad;
    }
    wait_and_unignore(time) {
      self endon("death");
      wait(time);
      self solo_set_pacifist(false);
      self.ignoreme = false;
      self.health = 100;
    }
    wait_and_spawn(time) {
      wait time;
      self stalingradspawn();
    }
    wait_and_openflag(time, myflag) {
      wait time;
      flag_clear(myflag);
    }
    wait_and_killspawner(time, num) {
      wait time;
      maps\_spawner::kill_spawnernum(num);
    }
    goal_failsafe(time) {
      self endon("death");
      self endon("goal");
      wait time;
      self notify("goal");
    }
    reset_hero_run_anim_trigs() {
      trigs = getentarray("hero_runanim_trigs", "script_noteworthy");
      array_thread(trigs, ::trig_reset_hero_anim);
      trigs = getentarray("hero_downstairs_trigs", "script_noteworthy");
      array_thread(trigs, ::downstairs_runanim);
      trigs = getentarray("hero_upstairs_trigs", "script_noteworthy");
      array_thread(trigs, ::upstairs_runanim);
    }
    trig_reset_hero_anim() {
      while (1) {
        self waittill("trigger", triggerer);
        if(triggerer == level.hero) {
          break;
        }
        wait 0.05;
      }
      level.hero set_run_anim("e1_street_run");
      wait 2;
      self delete();
    }
    downstairs_runanim() {
      while (1) {
        self waittill("trigger", triggerer);
        if(triggerer == level.hero) {
          break;
        }
        wait 0.05;
      }
      level.hero set_run_anim("stairs_down");
      wait 2;
      self delete();
    }
    upstairs_runanim() {
      while (1) {
        self waittill("trigger", triggerer);
        if(triggerer == level.hero) {
          break;
        }
        wait 0.05;
      }
      level.hero set_run_anim("stair_run");
      wait 2;
      self delete();
    }
    count_teh_time() {
      level.tehtimecounter = 0;
      while (1) {
        level.tehtimecounter = level.tehtimecounter + 0.05;
        wait 0.05;
      }
    }
    fake_ppsh() {
      level.fake_ppsh = spawn("script_model", (112.834, 669.472, 2.01857));
      level.fake_ppsh.angles = (358.474, 359.958, -88.7951);
      level.fake_ppsh setmodel("weapon_rus_ppsh_smg");
    }
    stealth_checker() {
      level endon("stealthbreak");
      flag_clear("player_attacking");
      self thread action_attack_checker();
      while (1) {
        if(self isfiring()) {
          wait 0.1;
          if(flag("player_attacking")) {
            level notify("stealthbreak");
          }
        }
        if(self isthrowinggrenade()) {
          wait 4;
          level notify("stealthbreak");
        }
        wait 0.05;
      }
    }
    grenadetoss_is_attacking() {
      while (1) {
        if(self isthrowinggrenade()) {
          self notify("action_notify_attack");
        }
        wait 0.05;
      }
    }
    action_attack_checker() {
      level endon("stealthbreak");
      lastclipcount = level.player getcurrentweaponclipammo();
      weap = level.player getcurrentweapon();
      lastammocount = level.player getammocount(weap);
      while (1) {
        weap = level.player getcurrentweapon();
        clipcount = level.player getcurrentweaponclipammo();
        ammocount = level.player getammocount(weap);
        weap = level.player getcurrentweapon();
        if(clipcount < lastclipcount || ammocount < lastammocount) {
          flag_set("player_attacking");
        }
        lastclipcount = clipcount;
        lastammocount = ammocount;
        wait 0.05;
      }
    }
    streetdudes_findyou() {
      self endon("death");
      level waittill("found_infountain");
      guys_areclose = 0;
      level.e1_timing_feedback = "could_b_quicker";
      flag_set("found_infountain_reznov_hide");
      spot = getstruct("fountain_reznov_align_spot", "targetname");
      spot notify("stop_loop");
      spot thread anim_loop_solo(level.hero, "resnov_gun_loop", undefined, "stop_loop");
      if(isDefined(level.scr_anim[self.animname]["react"]) && isDefined(self.animspot) && isDefined(self.deathanim)) {
        self.animspot anim_single_solo(self, "react");
      }
      self solo_set_pacifist(false);
      node = getnode(self.script_noteworthy + "_covernode", "script_noteworthy");
      if(isDefined(node)) {
        self setgoalnode(node);
      } else {
        self setgoalentity(get_players()[0]);
      }
      self thread wait_and_chargeplayer(randomintrange(7, 40));
      while (guys_areclose == 0) {
        axis = getaiarray("axis");
        for (i = 0; i < axis.size; i++) {
          dist = distance(level.hero.origin, axis[i].origin);
          if(dist < 250) {
            guys_areclose = 1;
          }
        }
        wait 0.05;
      }
      flag_set("found_infountain");
      spot notify("stop_loop");
      level.hero stopanimscripted();
      level.hero.health = 1;
      level.hero solo_set_pacifist(false);
      if(!isDefined(level.hero.saidfoundus)) {
        level.hero.saidfoundus = 1;
        level thread say_dialogue("found_us");
        level thread maps\sniper_event1::hunters_after_hero_infountain();
      }
    }
    adjust_angles_to_player(stumble_angles) {
      pa = stumble_angles[0];
      ra = stumble_angles[2];
      rv = anglestoright(level.player.angles);
      fv = anglestoforward(level.player.angles);
      rva = (rv[0], 0, rv[1] * -1);
      fva = (fv[0], 0, fv[1] * -1);
      angles = vector_multiply(rva, pa);
      angles = angles + vector_multiply(fva, ra);
      return angles + (0, stumble_angles[1], 0);
    }
    do_custom_introscreen() {
      custom_introscreen(&"SNIPER_INTROSCREEN_TITLE", & "SNIPER_INTROSCREEN_DATE", & "SNIPER_INTROSCREEN_PLACE", & "SNIPER_INTROSCREEN_INFO", & "SNIPER_INTROSCREEN_INFO2");
    }
    custom_introscreen(string1, string2, string3, string4, string5) {
      if(GetDvar("introscreen") == "0") {
        waittillframeend;
        level notify("finished final intro screen fadein");
        waittillframeend;
        flag_set("starting final intro screen fadeout");
        waittillframeend;
        level notify("controls_active");
        waittillframeend;
        flag_set("introscreen_complete");
        flag_set("pullup_weapon");
        return;
      }
      if(level.start_point != "default") {
        return;
      }
      level.introstring = [];
      wait 2;
      setmusicstate("BOMBERS");
      wait 0.5;
      if(isDefined(string1)) {
        maps\_introscreen::introscreen_create_line(string1, "lower_left");
      }
      wait(2);
      if(isDefined(string2)) {
        maps\_introscreen::introscreen_create_line(string2, "lower_left");
        wait 2;
      }
      if(isDefined(string3)) {
        maps\_introscreen::introscreen_create_line(string3, "lower_left");
        wait 1.5;
      }
      if(isDefined(string4)) {
        maps\_introscreen::introscreen_create_line(string4, "lower_left");
        wait 1.5;
      }
      if(isDefined(string5)) {
        maps\_introscreen::introscreen_create_line(string5, "lower_left");
      }
      wait 3;
      level thread maps\_introscreen::introscreen_fadeOutText();
    }
    random_walk() {
      num = randomint(100);
      if(num < 33) {
        return "street_patrol1";
      }
      if(num < 66) {
        return "street_patrol2";
      } else {
        return "street_patrol3";
      }
    }
    swap_struct_with_origin() {
      spot = spawn("script_origin", self.origin);
      if(isDefined(self.angles)) {
        spot.angles = self.angles;
      }
      return spot;
    }
    getstructent(key, value) {
      spot1 = getstruct(key, value);
      spot2 = spawn("script_origin", spot1.origin);
      if(isDefined(spot1.angles)) {
        spot2.angles = spot1.angles;
      }
      return spot2;
    }
    origin_counter() {
      while (1) {
        spots = getentarray("script_origin", "classname");
        trigs = getentarray("trigger_radius", "classname");
        trigs2 = getentarray("trigger_multiple", "classname");
        models = getentarray("script_model", "classname");
        brushes = getentarray("script_brushmodel", "classname");
        dest = getentarray("destructible", "targetname");
        angles = level.player getplayerangles();
        gun = getent("e3_cover_mg", "script_noteworthy");
        nades = level.player getweaponammostock("stick_grenade");
        weap = level.player getcurrentweapon();
        wait 2;
      }
    }
    delete_origins_afterfight() {
      level waittill("e3_fightison");
      wait 2;
      self delete();
    }
    #using_animtree("sniper_crows");

    its_curtains_for_ya() {
      self notify("newcurtain_anim");
      self endon("death");
      self endon("newcurtain_anim");
      if(!isDefined(self.animated)) {
        self.animated = 1;
      }
      self UseAnimTree(#animtree);
      self.animname = "curtain";
      spot = getstruct("dog_bark_node", "targetname");
      if((!isDefined(self.animating) || (isDefined(self.animating) && self.animating == 0)) && self.animated < 5) {
        wait 0.2;
        myanim = get_curtain_anim("flaming_intro");
        self anim_single_solo(self, myanim);
        if(!isDefined(self.flaming)) {
          self thread curtain_fx();
          self.flaming = 1;
        }
        self.animating = 1;
      } else {
        self.animating = 1;
        myanim = get_curtain_anim("flaming_loop");
        self anim_single_solo(self, myanim);
      }
      self.animated++;
      myanim = get_curtain_anim("flaming_loop");
      self anim_single_solo(self, myanim);
      animtime = getanimlength(level.scr_anim["curtain"][myanim]);
      myanim = get_curtain_anim("flaming_outtro");
      self anim_single_solo(self, myanim);
      self.animating = 0;
      myanim = get_curtain_anim("calm_loop");
      self anim_loop_solo(self, myanim, undefined, "newcurtain_anim");
    }
    get_curtain_anim(myanim) {
      int = randomintrange(1, 4);
      mystring = myanim + int;
      return mystring;
    }
    curtain_fx() {
      bone = [];
      bone[0] = "curt_r2_04";
      bone[1] = "curt_r1_01";
      bone[2] = "curt_r2_01";
      bone[3] = "curt_r3_01";
      bone[4] = "curt_r1_02";
      bone[5] = "curt_r2_02";
      bone[6] = "curt_r3_02";
      bone[7] = "curt_r1_03";
      bone[8] = "curt_r2_03";
      bone[9] = "curt_r3_03";
      counter = 0;
      while (counter < 4) {
        for (i = 0; i < bone.size; i++) {
          toss = randomint(100);
          if(toss > 80 && counter < 5) {
            playfxontag(level._effect["fire_debris_small"], self, bone[i]);
            counter++;
          }
        }
      }
    }
    e2_flamer_struct_movers() {
      self endon("death");
      while (1) {
        xval = randomint(5);
        zval = randomint(3);
        pitchvar = randomint(10);
        if(cointoss()) {
          pitchvar = pitchvar * -1;
        }
        yawvar = randomint(10);
        if(cointoss()) {
          yawvar = yawvar * -1;
        }
        time = randomintrange(2, 6);
        self rotateto(self.angles + (pitchvar, yawvar, 0), time);
        self moveto(self.origin + (xval, 0, zval), time);
        wait time;
        self rotateto(self.angles + (pitchvar * -1, yawvar * -1, 0), time);
        self moveto(self.origin + (xval * -1, 0, zval * -1), time);
        wait time;
      }
    }
    fire_hurts_trigs() {
      self endon("death");
      while (1) {
        if(level.player istouching(self)) {
          level.player setburn(0.5);
          level.player dodamage(10, self.origin);
        }
        wait 1;
      }
    }
    is_player_scoped() {
      flag_set("did_noscope");
      flag_wait("friendlies_vignette_go");
      flag_clear("did_noscope");
      level endon("said_noscope");
      while (1) {
        if(level.player AdsButtonPressed()) {
          flag_set("player_is_ads");
          wait 1;
        } else {
          flag_clear("player_is_ads");
        }
        wait 0.3;
      }
    }
    random_offset(xoffset, yoffset, zoffset) {
      x = randomint(xoffset);
      y = randomint(yoffset);
      z = randomint(zoffset);
      if(cointoss()) {
        x = x * 1;
      }
      if(cointoss()) {
        y = y * 1;
      }
      if(cointoss()) {
        z = z * 1;
      }
      return (x, y, z);
    }
    kill_on_hit(ender, shotspot, attacker) {
      level endon(ender);
      self waittill("damage");
      if(isDefined(attacker)) {
        self dodamage(self.health * 10, (shotspot), attacker, attacker);
      } else {
        self dodamage(self.health * 10, (shotspot));
      }
    }
    playsound_generic_facial(sound, lookTarget) {
      self endon("death");
      self endon("disconnect");
      notifyString = "sound_done";
      self thread maps\_anim::anim_facialFiller(notifyString, lookTarget);
      self animscripts\face::SaySpecificDialogue(undefined, sound, 1.0, notifyString);
      self waittill(notifyString);
    }
    play_random_dialogue(line1, line2, line3, line4, line5, line6) {
      lines = [];
      if(isDefined(line1)) {
        lines = array_add(lines, line1);
      }
      if(isDefined(line2)) {
        lines = array_add(lines, line2);
      }
      if(isDefined(line3)) {
        lines = array_add(lines, line3);
      }
      if(isDefined(line4)) {
        lines = array_add(lines, line4);
      }
      if(isDefined(line5)) {
        lines = array_add(lines, line5);
      }
      if(isDefined(line6)) {
        lines = array_add(lines, line6);
      }
      while (1) {
        myline = lines[randomint(lines.size)];
        if(!isDefined(level.lastrandomline) || level.lastrandomline != myline) {
          level.lastrandomline = myline;
          break;
        }
      }
      level thread say_dialogue(myline);
    }
    friendly_fire_check() {
      level.friendlyfirecount = 0;
      while (1) {
        level.hero waittill("damage", damage, attacker);
        level thread friendly_fire_reset();
        if(attacker == level.player) {
          level.friendlyfirecount++;
        }
        if(level.friendlyfirecount > 1) {
          SetDvar("ui_deadquote", & "SCRIPT_MISSIONFAIL_KILLTEAM_RUSSIAN");
          missionfailed();
        }
      }
    }
    friendly_fire_reset() {
      level notify("new_ff_reset_counter");
      level endon("new_ff_reset_counter");
      wait 30;
      level.friendlyfirecount = 0;
    }
    reznov_killed_streetguys() {
      self waittill("damage", damage, attacker);
      if(attacker == level.hero) {
        flag_set("reznov_shot_street_guys");
      }
    }