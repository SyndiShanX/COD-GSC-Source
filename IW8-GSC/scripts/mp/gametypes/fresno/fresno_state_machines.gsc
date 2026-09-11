/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\fresno\fresno_state_machines.gsc
*****************************************************************/

function wait_juggernaut_announce(var0) {
  var0 notify("frenzy_event_ready");
  var0 scripts\mp\gametypes\br_alt_mode_mxp::tplayinterruptableanim("s4_mp_kenosha_idle_taunt_01");
}

function kheadtofrenzypoint(var0) {
  var1 = get_jump_origin();

  if(isDefined(var1)) {
    light_kk_monolith(level.ref_11e18.wait_for_player_eliminated[var1]);
    scripts\mp\gametypes\br_alt_mode_mxp::waitforremoteend(var0, var1);
    return;
  }

  light_kk_monolith(level.ref_11e18.wait_for_player_eliminated[level.ref_11e18.wait_for_open]);
}

function vehicle_occupancy_showcashbag(var0) {
  if(level.ref_11e18.ref_13bef[var0.agent_type] >= level.delayedeventtypes[16].secondwindthink) {
    if(istrue(var0.„Û C ZJ[å()) {
          return 0;
        }

        var0 thread scripts\mp\gametypes\br_publicevent_fresno::kk_onkilled(); var0 scripts\mp\gametypes\br_alt_mode_mxp::tplayinterruptableanim("s4_mp_kenosha_idle_staggered_01");
        return 0;
      }

      return scripts\mp\gametypes\br_publicevents::upload_station_interact_used_think(16);
    }

    function wait_for_tank_death(var0) {
      var1 = var0 scripts\mp\gametypes\_mxp_target::play_players_arrive_at_extraction(level.ref_11e18.playerredeploy);
      scripts\mp\gametypes\br_alt_mode_mxp::waitandstartparachuteoverheadmonitoring(6);
      ref_11e19(var0, var1, &scripts\mp\gametypes\br_alt_mode_mxp::vehicleturretshootthread);
    }

    function wait_for_tanks_almost_gone(var0) {
      var1 = getdvarint("scr_br_pe_fresno_frenzy_ideal_range_kk", 450);
      var2 = var0 scripts\mp\gametypes\br_publicevent_fresno::propspectating(var1, level.ref_11e18.setincomingremovedcallback.ref_13f03);

      if(!isDefined(var2)) {
        if(!var0.ref_11ea7) {
          var0 scripts\mp\gametypes\br_alt_mode_mxp::tplayinterruptableanim("s4_mp_kenosha_idle_taunt_01");
          var0.ref_11ea7 = 1;
          return;
        }

        kstateinterruptableidle(var0);
        return;
      }

      if(isPlayer(var2)) {
        var0.ref_13f03 = var2;
      } else if(isDefined(var2.ºT° Í× c, ^ •' ) ) {
          var0.ref_13f03 = var2.ºT° Í× c, ^ •';
        }

        scripts\mp\gametypes\br_alt_mode_mxp::wait_in_spectate_for_time(var0); var3 = scripts\mp\gametypes\br_alt_mode_mxp::randomizeattacklocation(var2.origin, level.ref_11e18.waitandstartplunderpolling); var4 = scripts\mp\gametypes\br_public::semtex_used(); var3 = scripts\mp\gametypes\br_public::modifyplayer_damage(var3, abs(var3[2]) + var4); ref_11e19(var0, var3, &scripts\mp\gametypes\br_alt_mode_mxp::vehicleturretshootthread); var5 = vectortoangles(var3 - var0.origin); _getrandomlocations::vehicle_spawn_cp_gamemodesupportsabandonedtimeout(var3, var5, level.ref_11e18.waitandstartplunderpolling); waitframe(); scripts\mp\gametypes\br_alt_mode_mxp::waitfornukecarriernearlz(var0); var0.ref_13f03 = undefined;
      }

      function kreturntonormal(var0) {
        disable_kk_monolith();
        scripts\mp\gametypes\br_alt_mode_mxp::wait_in_spectate_for_time(var0);
        var0.ref_11ea4 = var0.ref_11f40;
        level.ref_11e18.wait_and_destroy = undefined;
      }

      function kstateinterruptableidle(var0, var1) {
        if(!isDefined(var0.’K

            ¸ AÏ7 @µåx) || var0.’K

          ¸ AÏ7 @µåx + 1 >= level.ref_11e18.­ÚÒFc•¹.size) {
          var0.’K

          ¸ AÏ7 @µåx = 0;
          var0.—; - c¬ æ = scripts\engine\utility::array_randomize(level.ref_11e18.­ÚÒFc•¹);
        } else {
          var0.’K

          ¸ AÏ7 @µåx++;
        }

        var2 = var0.’K

        ¸ AÏ7 @µåx;
        var3 = var0.—; - c¬ æ[var2];
        var0 scripts\mp\gametypes\br_alt_mode_mxp::tplayinterruptableanim(var3);
        var0.nodeidle = 1;
      }

      function gprogresstofrenzylocation(var0, var1, var2) {
        var3 = scripts\engine\utility::ter_op(var1 == level.ref_11e18.setlethalonunresolvedcollision.size - 1, 0, var1 + 1);
        var4 = scripts\mp\gametypes\br_alt_mode_mxp::score_init(var0, var1);

        if(var0.linked_mover) {
          if(var3 != level.ref_11e18.setlastdroppableweaponobj && !var4) {
            var0.linked_mover = 0;
          }
        } else if(var1 != level.ref_11e18.setlastdroppableweaponobj && !var4) {
          var0.linked_mover = 1;
        }

        var5 = scripts\engine\utility::ter_op(var0.linked_mover, var3, var1);

        if(getdvarint("disable_swim_to_frenzy", 0)) {
          while(level.ref_11e18.setlastdroppableweaponobj != var5) {
            gwalkonpathtowardfrenzypoint(var0);
            waitframe();
          }
        } else {
          if(!var4) {
            if(scripts\mp\gametypes\br_alt_mode_mxp::sat_computer_think_new() == 7) {
              scripts\mp\gametypes\br_alt_mode_mxp::set_relic_bang_and_boom(var0);
            }
          }

          glongtraveltonode(var0, var5);
        }

        gmoveoffpathtofrenzypoint(var0, var2);
      }

      function glongtraveltonode(var0, var1) {
        var2 = getstepsanddir(var0, var1);
        var3 = var2[0];
        var4 = var2[1];
        var2 = undefined;

        if(var3 > 0) {
          if(scripts\mp\gametypes\br_alt_mode_mxp::sat_computer_think_new() == 7) {
            var5 = scripts\mp\gametypes\br_alt_mode_mxp::sandboxprintlineboldwait(var0);
          } else {
            var5 = level.ref_11e18.setlastdroppableweaponobj;
            gstartandswimtonext(var1);
          }

          var6 = level.ref_11e18.setlethalonunresolvedcollision[var5];

          while(level.ref_11e18.setlastdroppableweaponobj != var2) {
            if(var5 != level.ref_11e18.setlastdroppableweaponobj && scripts\mp\gametypes\br_alt_mode_mxp::sat_computer_think_new() == 7) {
              var7 = scripts\mp\gametypes\br_alt_mode_mxp::sandboxprintlinebold(var1);
              var8 = level.ref_11e18.setlethalonunresolvedcollision[var7];
              var9 = vectorNormalize(var1.origin - var6);
              var10 = vectorNormalize(var8 - var1.origin);
              var11 = vectordot(var10, var9);

              if(var11 > getdvarfloat("scr_mxp_swim_angle_cos", 0.97)) {
                gcontinueswimtonext(var1, var8);
                continue;
              }
            }

            var5 = level.ref_11e18.setlastdroppableweaponobj;
            var6 = level.ref_11e18.setlethalonunresolvedcollision[var5];
            scripts\mp\gametypes\br_alt_mode_mxp::set_relic_bang_and_boom(var1);
            gstartandswimtonext(var1);
          }
        }

        if(scripts\mp\gametypes\br_alt_mode_mxp::sat_computer_think_new() == 7) {
          scripts\mp\gametypes\br_alt_mode_mxp::set_relic_bang_and_boom(var1);
          return;
        }
      }

      function gcontinueswimtonext(var0, var1) {
        scripts\mp\gametypes\br_alt_mode_mxp::set_maze_ai_stealth_settings(6);
        var0 scripts\mp\gametypes\br_alt_mode_mxp::ref_13c1c("s4_mp_greenbay_swim_01");
        scripts\mp\gametypes\br_alt_mode_mxp::set_maze_ai_stealth_settings(6);
        thread scripts\mp\gametypes\br_alt_mode_mxp::gstatemovetorootmotion(var0, var1);

        while(scripts\mp\gametypes\br_alt_mode_mxp::sat_computer_think_new() != 7) {
          waitframe();
        }

        scripts\mp\gametypes\br_alt_mode_mxp::set_player_munition_currency(var0);
      }

      function gstartandswimtonext(var0) {
        scripts\mp\gametypes\br_alt_mode_mxp::set_relic_amped(var0);

        while(scripts\mp\gametypes\br_alt_mode_mxp::sat_computer_think_new() != 7) {
          waitframe();
        }

        scripts\mp\gametypes\br_alt_mode_mxp::set_player_munition_currency(var0);
      }

      function gwalkonpathtowardfrenzypoint(var0) {
        scripts\mp\gametypes\br_alt_mode_mxp::set_relic_dogtags(var0);
        gcompletemovetonextnode(var0);
      }

      function getstepsanddir(var0, var1) {
        var2 = level.ref_11e18.setlastdroppableweaponobj - var1;
        var3 = 0;

        if(abs(var2) > 0) {
          var4 = 0;
          var5 = 0;

          if(var2 > 0) {
            var4 = var2;
            var5 = level.ref_11e18.setlethalonunresolvedcollision.size - level.ref_11e18.setlastdroppableweaponobj + var1;
          } else {
            var5 = 0 - var2;
            var4 = level.ref_11e18.setlethalonunresolvedcollision.size - var1 + level.ref_11e18.setlastdroppableweaponobj;
          }

          var2 = min(var5, var4);

          if(var4 > var5 && var0.linked_mover) {
            var3 = 1;
          } else if(var5 > var4 && !var0.linked_mover) {
            var3 = 1;
          }
        }

        return [var2, var3];
      }

      function gmoveoffpathtofrenzypoint(var0, var1) {
        var2 = var1 - var0.origin;
        var3 = vectortoangles(var2);
        var4 = angleclamp180(var3[1]);
        scripts\mp\gametypes\br_alt_mode_mxp::set_relic_explodedmg(var0, var4, var1);
        gstatemovetotarget(var0, var1);
        scripts\mp\gametypes\br_alt_mode_mxp::set_relic_doomslayer(var0);

        if(isDefined(level.ref_11e18.—R ì = ×k· Ü½± - G4)) {
          var5 = level.ref_11e18.—R ì = ×k· Ü½± - G4.origin;
          ref_11e19(var0, var5, &scripts\mp\gametypes\br_alt_mode_mxp::sat_activate);
        }

        scripts\mp\gametypes\br_alt_mode_mxp::set_maze_ai_stealth_settings(0);
      }

      function gheadtofrenzypoint(var0) {
        var1 = scripts\mp\gametypes\br_alt_mode_mxp::sat_computer_think_new();

        if(var1 == 14 || var1 == 15) {
          level.ref_11e18.wait_for_next_hack_complete notify("break_idle");
          scripts\mp\gametypes\br_alt_mode_mxp::set_maze_ai_stealth_settings(12);
        }

        gcompletemovetonextnode(var0);
        var2 = ggetsafepoint();
        var3 = var2[0];
        var4 = var2[1];
        var2 = undefined;
        light_gz_monolith(var4);
        gprogresstofrenzylocation(var0, var3, var4);
      }

      function gcontinuewalktonextnode(var0) {
        while(!scripts\mp\gametypes\br_alt_mode_mxp::score_event_kill(var0)) {
          ganimatewalkwithoutovershooting(var0);
        }

        scripts\mp\gametypes\br_alt_mode_mxp::set_relic_grounded(var0, 12, 1);
        scripts\mp\gametypes\br_alt_mode_mxp::set_player_munition_currency(var0);
      }

      function ganimatewalkwithoutovershooting(var0) {
        thread gmonitorwalk(var0);
        var0 notify("gz_at_node");
        var1 = var0 scripts\mp\gametypes\br_alt_mode_mxp::ref_13c1c("s4_mp_greenbay_walk_01");
        var2 = getanimlength(var1);
        var3 = var0 scripts\engine\utility::waittill_notify_or_timeout_return("gz_at_node", var2);
        var0 notify("walk_cycle_done");
        return var3 == "timeout";
      }

      function gmonitorwalk(var0) {
        var0 notify("goal_stopped");
        var0 endon("goal_stopped");
        var0 endon("walk_cycle_done");

        for(;;) {
          if(scripts\mp\gametypes\br_alt_mode_mxp::score_event_kill(var0)) {
            var0 notify("gz_at_node");
            return;
          }

          waitframe();
        }
      }

      function gstatemovetotarget(var0, var1) {
        var0 endon("goal_reached");
        var0 endon("goal_interrupted");
        scripts\mp\gametypes\br_alt_mode_mxp::set_maze_ai_stealth_settings(2);

        while(scripts\mp\gametypes\br_alt_mode_mxp::sat_computer_think_new() == 2) {
          gstatecontinuetotarget(var0, var1);
        }

        scripts\mp\gametypes\br_alt_mode_mxp::set_maze_ai_stealth_settings(12);
      }

      function gcompletemovetonextnode(var0) {
        var0 notify("goal_stopped");

        if(scripts\mp\gametypes\br_alt_mode_mxp::ginwalkingstate()) {
          gcontinuewalktonextnode(var0);
        }

        for(var1 = scripts\mp\gametypes\br_alt_mode_mxp::sat_computer_think_new(); var1 == 6; var1 = scripts\mp\gametypes\br_alt_mode_mxp::sat_computer_think_new()) {
          waitframe();
        }

        if(var1 == 7) {
          scripts\mp\gametypes\br_alt_mode_mxp::set_player_munition_currency(var0);

          if(getdvarint("disable_swim_to_frenzy", 0)) {
            scripts\mp\gametypes\br_alt_mode_mxp::set_relic_bang_and_boom(var0);
            return;
          }

          return;
        }
      }

      function gstatecontinuetotarget(var0, var1) {
        var0 endon("goal_reached");
        var0 endon("goal_interrupted");
        thread gmonitortotarget(var0, var1);
        var0 scripts\mp\gametypes\br_alt_mode_mxp::ref_13c1d("s4_mp_greenbay_walk_01");
        var0 notify("walk_cycle_done");
      }

      function gmonitortotarget(var0, var1) {
        var0 notify("goal_stopped");
        var0 endon("goal_stopped");
        var0 endon("walk_cycle_done");

        for(;;) {
          if(gisclosetofrenzypoint(var0, var1)) {
            var0 notify("goal_reached");
            return;
          }

          waitframe();
        }
      }

      function gisclosetofrenzypoint(var0, var1) {
        var2 = 100;
        var3 = distance2d(var1, var0.origin);

        if(var3 <= level.ref_11e18.ŽÅ _8šä Pªs) {
          return true;
        }

        var4 = var1 - var0.origin;
        var5 = var0.angles;
        var6 = anglesToForward(var5);
        var7 = vectordot(var4, var6);
        return var7 <= 0;
      }

      function trunidlewait(var0) {
        self notify("frenzy_event_ready");
        self endon("frenzy_event_ready");

        for(;;) {
          scripts\mp\gametypes\br_alt_mode_mxp::ref_13c1d(var0);
        }
      }

      function set_dvars(var0) {
        var0 notify("frenzy_event_ready");
        var0 scripts\mp\gametypes\br_alt_mode_mxp::tplayinterruptableanim("s4_mp_greenbay_idle_taunt_01");
      }

      function post_blockade_breadcrumb_struct(var0) {
        if(level.ref_11e18.ref_13bef[var0.agent_type] >= level.delayedeventtypes[16].secondwindthink) {
          if(istrue(var0.„Û C ZJ[å()) {
                return 0;
              }

              var0 thread scripts\mp\gametypes\br_publicevent_fresno::gz_onkilled(); var0 scripts\mp\gametypes\br_alt_mode_mxp::ref_13c1d("s4_mp_greenbay_idle_staggered_01");
              return 0;
            }

            return scripts\mp\gametypes\br_publicevents::upload_station_interact_used_think(16);
          }

          function select_woods_two_spawners(var0) {
            scripts\mp\gametypes\br_alt_mode_mxp::set_maze_ai_stealth_settings(0);
            var1 = var0.cashtorefund;
            var2 = var1 scripts\mp\gametypes\_mxp_target::play_players_arrive_at_extraction(var1.radius);
            scripts\mp\gametypes\br_alt_mode_mxp::set_maze_ai_stealth_settings(13);
            ref_11e19(var0, var2, &scripts\mp\gametypes\br_alt_mode_mxp::sat_activate);
          }

          function send_munition_used_notify(var0) {
            var1 = getdvarint("scr_br_pe_fresno_frenzy_ideal_range_gz", 900);
            var2 = var0 scripts\mp\gametypes\br_publicevent_fresno::propspectating(var1, level.ref_11e18.wait_for_next_hack_complete.ref_13f03);

            if(!isDefined(var2)) {
              if(!var0.ref_11ea7) {
                var0 scripts\mp\gametypes\br_alt_mode_mxp::tplayinterruptableanim("s4_mp_greenbay_idle_lookaround_01");
                var0.ref_11ea7 = 1;
                return;
              }

              gstateinterruptableidle(var0);
              return;
            }

            if(isPlayer(var2)) {
              var0.ref_13f03 = var2;
            } else if(isDefined(var2.ºT° Í× c, ^ •' ) ) {
                var0.ref_13f03 = var2.ºT° Í× c, ^ •';
              }

              scripts\mp\gametypes\br_alt_mode_mxp::set_distances_for_groups(var0); var3 = scripts\mp\gametypes\br_alt_mode_mxp::randomizeattacklocation(var2.origin, level.ref_11e18.‘·³æ[[–±6n Ž '¬ÂÚ“,‘ZÕÜ );
                    var4 = scripts\mp\gametypes\br_public::semtex_used();
                    var5 = scripts\mp\gametypes\br_public::modifyplayer_damage(var3, abs(var3[2]) + var4);
                    var6 = level.ref_11e18.šI 'óïûˆ2Š€Í%;(e Ýy#s < var3[ 2 ] - var5[ 2 ];

                    if(var6) {
                      var7 = vectortoangles(var3 - var0.origin);
                      _getrandomlocations::greenbaystrikeatpoint(var3, var7, level.ref_11e18.‘·³æ[[–±6n Ž '¬ÂÚ“,‘ZÕÜ );
                            }
                            else {
                              var7 = vectortoangles(var6 - var1.origin);
                              _getrandomlocations::serverroomdogtagrevive(var6, var7, level.ref_11e18.‘·³æ[[–±6n Ž '¬ÂÚ“,‘ZÕÜ );
                                    }

                                    waitframe(); scripts\mp\gametypes\br_alt_mode_mxp::set_relic_grounded(var1, 0, 0); scripts\mp\gametypes\br_alt_mode_mxp::set_relic_aggressive_melee_params(var1); var1.ref_13f03 = undefined;
                                  }

                                  function gstateinterruptableidle(var0, var1) {
                                    if(!isDefined(var0.’K

                                        ¸ AÏ7 @µåx) || var0.’K

                                      ¸ AÏ7 @µåx + 1 >= level.ref_11e18.¾w§ PX "Ö.size ) {
                                      var0.’K

                                      ¸ AÏ7 @µåx = 0; var0.—; - c¬ æ = scripts\engine\utility::array_randomize(level.ref_11e18.¾w§ PX "Ö );
                                      }
                                      else {
                                        var0.’K

                                        ¸ AÏ7 @µåx++;
                                      }

                                      var2 = var0.’K

                                      ¸ AÏ7 @µåx; var3 = var0.—; - c¬ æ[var2]; var0 scripts\mp\gametypes\br_alt_mode_mxp::tplayinterruptableanim(var3); var0.nodeidle = 1;
                                    }

                                    function set_door_open(var0) {
                                      disable_gz_monolith();
                                      var1 = scripts\mp\gametypes\br_alt_mode_mxp::sandboxprintlinebold(var0);
                                      var2 = level.ref_11e18.setlethalonunresolvedcollision[var1];
                                      ref_11e19(var0, var2, &scripts\mp\gametypes\br_alt_mode_mxp::sat_activate);
                                      scripts\mp\gametypes\br_alt_mode_mxp::set_maze_ai_stealth_settings(1);
                                      var0 scripts\mp\gametypes\br_alt_mode_mxp::ref_13c1d("s4_mp_greenbay_walk_start_01");
                                      scripts\mp\gametypes\br_alt_mode_mxp::set_maze_ai_stealth_settings(2);
                                      var0.chopper_carepackage = undefined;
                                      var0.nodeidle = 1;
                                    }

                                    function gswimouttosea(var0, var1) {
                                      scripts\mp\gametypes\br_alt_mode_mxp::set_maze_ai_stealth_settings(5);
                                      var0 scripts\mp\gametypes\br_alt_mode_mxp::ref_13c1d("s4_mp_greenbay_dive_01");
                                      scripts\mp\gametypes\br_alt_mode_mxp::set_maze_ai_stealth_settings(6);
                                      var0 scripts\mp\gametypes\br_alt_mode_mxp::ref_13c1c("s4_mp_greenbay_swim_01");
                                      scripts\mp\gametypes\br_alt_mode_mxp::gstatemovetorootmotion(var0, var1);
                                    }

                                    function gstatecontinueswimming(var0) {
                                      var0 scripts\mp\gametypes\br_alt_mode_mxp::ref_13c1c("s4_mp_greenbay_swim_01");
                                      var1 = scripts\mp\gametypes\br_alt_mode_mxp::sandboxprintlinebold(var0);
                                      var2 = level.ref_11e18.setlethalonunresolvedcollision[var1];
                                      thread scripts\mp\gametypes\br_alt_mode_mxp::gstatemovetorootmotion(var0, var2);
                                    }

                                    function ggetsafepoint() {
                                      var2 = level.ref_11e18.setincomingremovedcallback scripts\engine\utility::array_sort_with_func(getarraykeys(level.ref_11e18.seq3_tanksettings), &scripts\mp\gametypes\br_alt_mode_mxp::post_race);

                                      if(!isDefined(level.br_circle.dangercircleent)) {
                                        var1 = level.ref_11e18.seq3_tanksettings[var2[0]];
                                        return [var1.score_event_civilian_killed, var1.origin];
                                      }

                                      var3 = min(6, var1.size / 2);

                                      for(var4 = 0; var4 < var3; var4++) {
                                        var5 = var1[var4];
                                        var1 = level.ref_11e18.seq3_tanksettings[var5];

                                        if(is_safe_point(var1.origin)) {
                                          return [var1.score_event_civilian_killed, var1.origin];
                                        }
                                      }

                                      var1 = level.ref_11e18.seq3_tanksettings[var1[0]];
                                      return [var1.score_event_civilian_killed, var1.origin];
                                    }

                                    function is_safe_point(var0) {
                                      if(istrue(level.br_circle_disabled)) {
                                        return true;
                                      }

                                      if(!isDefined(level.br_circle.dangercircleent) || !isDefined(level.br_circle.safecircleent)) {
                                        return false;
                                      }

                                      if(!scripts\mp\gametypes\br_circle::ispointincurrentsafecircle(var0)) {
                                        return false;
                                      }

                                      if(scripts\mp\gametypes\br_circle::updatescavengerhud(var0)) {
                                        return true;
                                      }

                                      if(isDefined(level.ref_11e18.ºË§!jÚ `ðU% ) && isDefined( level.ref_11e18.Œ„ß¡ÿ±§sz óù·Ø5§œch' ) )
{
return ( level.ref_11e18.Œ„ß¡ÿ±§sz óù·Ø5§œch' > level.ref_11e18.ºË§!jÚ `
                                          ðU % );
                                      }

                                      return false;
                                    }

                                    function get_jump_origin() {
                                      var0 = level.ref_11e18.wait_for_open;
                                      var1 = level.ref_11e18.wait_for_open;

                                      for(var2 = 0; var2 < level.ref_11e18.wait_for_player_eliminated.size; var2++) {
                                        var0 = scripts\engine\utility::ter_op(var0 + 1 < level.ref_11e18.wait_for_player_eliminated.size, var0 + 1, 0);
                                        var3 = level.ref_11e18.wait_for_player_eliminated[var0];

                                        if(var0 > 0 && level.ref_11e18.wait_for_open != var0 && is_safe_point(var3)) {
                                          return var0;
                                        }

                                        var1 = scripts\engine\utility::ter_op(var1 > 0, var1 - 1, level.ref_11e18.wait_for_player_eliminated.size - 1);
                                        var4 = level.ref_11e18.wait_for_player_eliminated[var1];

                                        if(var1 > 0 && level.ref_11e18.wait_for_open != var0 && is_safe_point(var4)) {
                                          return var1;
                                        }
                                      }
                                    }

                                    function ref_11e19(var0, var1) {
                                      var2 = self.origin;
                                      var3 = self.angles;
                                      var4 = var0 - var2;
                                      var5 = vectortoangles(var4);
                                      var6 = angleclamp180(var5[1]);
                                      var7 = angleclamp180(var3[1]);
                                      var8 = angleclamp180(var6 - var7);
                                      var9 = [[var1]](self, var8);
                                      var10 = var9[0];
                                      var11 = var9[1];
                                      var12 = var9[2];
                                      var9 = undefined;
                                      var13 = 1;

                                      if(var10 != "") {
                                        var14 = scripts\mp\gametypes\br_alt_mode_mxp::tplayinterruptableanim(var10);
                                      }

                                      self orientmode("face point", var0);
                                      return var13;
                                    }

                                    function light_kk_monolith(var0) {
                                      var1 = getentitylessscriptablearrayinradius("scriptable_lm_mkg_cliff_rock_06_kenosha", "classname");
                                      var2 = undefined;
                                      var3 = float(1e+10);

                                      foreach(var5 in var1) {
                                        var6 = distancesquared(var5.origin, var0);

                                        if(var6 < var3) {
                                          var3 = var6;
                                          var2 = var5;
                                        }
                                      }

                                      if(isDefined(var2)) {
                                        var2 setscriptablepartstate("fx", "start");
                                      }

                                      level.ref_11e18.¬½ëÊ– Ï­­¢ Êð™ = var2;
                                      level thread scripts\mp\gametypes\br_publicevent_fresno::attackerisinflictorforradiusexplosiveweapon(var0, level.ref_11e18.wait_for_next_hack_complete);
                                    }

                                    function light_gz_monolith(var0) {
                                      var1 = getentitylessscriptablearrayinradius("scriptable_lm_mkg_cliff_rock_06_greenbay", "classname");
                                      var2 = undefined;
                                      var3 = float(1e+10);

                                      foreach(var5 in var1) {
                                        var6 = distancesquared(var5.origin, var0);

                                        if(var6 < var3) {
                                          var3 = var6;
                                          var2 = var5;
                                        }
                                      }

                                      if(isDefined(var2)) {
                                        var2 setscriptablepartstate("fx", "start");
                                      }

                                      level.ref_11e18.—R ì = ×k· Ü½± - G4 = var2;
                                      var8 = getdvarfloat("scr_br_pe_fresno_gz_offset", 1.16667);
                                      var9 = vectorNormalize(scripts\mp\gametypes\br_circle::getsafecircleorigin() - var0);
                                      var6 = level.ref_11e18.playerredeploy * var8;
                                      var10 = var0 + var9 * var6;
                                      level thread scripts\mp\gametypes\br_publicevent_fresno::attackerisinflictorforradiusexplosiveweapon(var10, level.ref_11e18.setincomingremovedcallback);
                                    }

                                    function disable_kk_monolith() {
                                      if(isDefined(level.ref_11e18.¬½ëÊ– Ï­­¢ Êð™)) {
                                        level.ref_11e18.¬½ëÊ– Ï­­¢ Êð™ setscriptablepartstate("fx", "stop");
                                      }

                                      level.ref_11e18.¬½ëÊ– Ï­­¢ Êð™ = undefined;
                                    }

                                    function disable_gz_monolith() {
                                      if(isDefined(level.ref_11e18.—R ì = ×k· Ü½± - G4)) {
                                        level.ref_11e18.—R ì = ×k· Ü½± - G4 setscriptablepartstate("fx", "stop");
                                      }

                                      level.ref_11e18.—R ì = ×k· Ü½± - G4 = undefined;
                                    }