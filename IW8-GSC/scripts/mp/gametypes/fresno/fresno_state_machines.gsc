/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\fresno\fresno_state_machines.gsc
*****************************************************************/

function wait_juggernaut_announce(var_0) {
  var_0 notify("frenzy_event_ready");
  var_0 scripts\mp\gametypes\br_alt_mode_mxp::tplayinterruptableanim("s4_mp_kenosha_idle_taunt_01");
}

function kheadtofrenzypoint(var_0) {
  var_1 = get_jump_origin();

  if(isDefined(var_1)) {
    light_kk_monolith(level.ref_11e18.wait_for_player_eliminated[var_1]);
    scripts\mp\gametypes\br_alt_mode_mxp::waitforremoteend(var_0, var_1);
    return;
  }

  light_kk_monolith(level.ref_11e18.wait_for_player_eliminated[level.ref_11e18.wait_for_open]);
}

function vehicle_occupancy_showcashbag(var_0) {
  if(level.ref_11e18.ref_13bef[var_0.agent_type] >= level.delayedeventtypes[16].secondwindthink) {
    if(istrue(var_0.„Û C ZJ[å()) {
          return 0;
        }

        var_0 thread scripts\mp\gametypes\br_publicevent_fresno::kk_onkilled(); var_0 scripts\mp\gametypes\br_alt_mode_mxp::tplayinterruptableanim("s4_mp_kenosha_idle_staggered_01");
        return 0;
      }

      return scripts\mp\gametypes\br_publicevents::upload_station_interact_used_think(16);
    }

    function wait_for_tank_death(var_0) {
      var_1 = var_0 scripts\mp\gametypes\_mxp_target::play_players_arrive_at_extraction(level.ref_11e18.playerredeploy);
      scripts\mp\gametypes\br_alt_mode_mxp::waitandstartparachuteoverheadmonitoring(6);
      ref_11e19(var_0, var_1, &scripts\mp\gametypes\br_alt_mode_mxp::vehicleturretshootthread);
    }

    function wait_for_tanks_almost_gone(var_0) {
      var_1 = getdvarint("scr_br_pe_fresno_frenzy_ideal_range_kk", 450);
      var_2 = var_0 scripts\mp\gametypes\br_publicevent_fresno::propspectating(var_1, level.ref_11e18.setincomingremovedcallback.ref_13f03);

      if(!isDefined(var_2)) {
        if(!var_0.ref_11ea7) {
          var_0 scripts\mp\gametypes\br_alt_mode_mxp::tplayinterruptableanim("s4_mp_kenosha_idle_taunt_01");
          var_0.ref_11ea7 = 1;
          return;
        }

        kstateinterruptableidle(var_0);
        return;
      }

      if(isPlayer(var_2)) {
        var_0.ref_13f03 = var_2;
      } else if(isDefined(var_2.ºT° Í× c, ^ •' ) ) {
          var_0.ref_13f03 = var_2.ºT° Í× c, ^ •';
        }

        scripts\mp\gametypes\br_alt_mode_mxp::wait_in_spectate_for_time(var_0); var_3 = scripts\mp\gametypes\br_alt_mode_mxp::randomizeattacklocation(var_2.origin, level.ref_11e18.waitandstartplunderpolling); var_4 = scripts\mp\gametypes\br_public::semtex_used(); var_3 = scripts\mp\gametypes\br_public::modifyplayer_damage(var_3, abs(var_3[2]) + var_4); ref_11e19(var_0, var_3, &scripts\mp\gametypes\br_alt_mode_mxp::vehicleturretshootthread); var_5 = vectortoangles(var_3 - var_0.origin); _getrandomlocations::vehicle_spawn_cp_gamemodesupportsabandonedtimeout(var_3, var_5, level.ref_11e18.waitandstartplunderpolling); waitframe(); scripts\mp\gametypes\br_alt_mode_mxp::waitfornukecarriernearlz(var_0); var_0.ref_13f03 = undefined;
      }

      function kreturntonormal(var_0) {
        disable_kk_monolith();
        scripts\mp\gametypes\br_alt_mode_mxp::wait_in_spectate_for_time(var_0);
        var_0.ref_11ea4 = var_0.ref_11f40;
        level.ref_11e18.wait_and_destroy = undefined;
      }

      function kstateinterruptableidle(var_0, var_1) {
        if(!isDefined(var_0.’K

            ¸ AÏ7 @µåx) || var_0.’K

          ¸ AÏ7 @µåx + 1 >= level.ref_11e18.­ÚÒFc•¹.size) {
          var_0.’K

          ¸ AÏ7 @µåx = 0;
          var_0.—; - c¬ æ = scripts\engine\utility::array_randomize(level.ref_11e18.­ÚÒFc•¹);
        } else {
          var_0.’K

          ¸ AÏ7 @µåx++;
        }

        var_2 = var_0.’K

        ¸ AÏ7 @µåx;
        var_3 = var_0.—; - c¬ æ[var_2];
        var_0 scripts\mp\gametypes\br_alt_mode_mxp::tplayinterruptableanim(var_3);
        var_0.nodeidle = 1;
      }

      function gprogresstofrenzylocation(var_0, var_1, var_2) {
        var_3 = scripts\engine\utility::ter_op(var_1 == level.ref_11e18.setlethalonunresolvedcollision.size - 1, 0, var_1 + 1);
        var_4 = scripts\mp\gametypes\br_alt_mode_mxp::score_init(var_0, var_1);

        if(var_0.linked_mover) {
          if(var_3 != level.ref_11e18.setlastdroppableweaponobj && !var_4) {
            var_0.linked_mover = 0;
          }
        } else if(var_1 != level.ref_11e18.setlastdroppableweaponobj && !var_4) {
          var_0.linked_mover = 1;
        }

        var_5 = scripts\engine\utility::ter_op(var_0.linked_mover, var_3, var_1);

        if(getdvarint("disable_swim_to_frenzy", 0)) {
          while(level.ref_11e18.setlastdroppableweaponobj != var_5) {
            gwalkonpathtowardfrenzypoint(var_0);
            waitframe();
          }
        } else {
          if(!var_4) {
            if(scripts\mp\gametypes\br_alt_mode_mxp::sat_computer_think_new() == 7) {
              scripts\mp\gametypes\br_alt_mode_mxp::set_relic_bang_and_boom(var_0);
            }
          }

          glongtraveltonode(var_0, var_5);
        }

        gmoveoffpathtofrenzypoint(var_0, var_2);
      }

      function glongtraveltonode(var_0, var_1) {
        var_2 = getstepsanddir(var_0, var_1);
        var_3 = var_2[0];
        var_4 = var_2[1];
        var_2 = undefined;

        if(var_3 > 0) {
          if(scripts\mp\gametypes\br_alt_mode_mxp::sat_computer_think_new() == 7) {
            var_5 = scripts\mp\gametypes\br_alt_mode_mxp::sandboxprintlineboldwait(var_0);
          } else {
            var_5 = level.ref_11e18.setlastdroppableweaponobj;
            gstartandswimtonext(var_1);
          }

          var_6 = level.ref_11e18.setlethalonunresolvedcollision[var_5];

          while(level.ref_11e18.setlastdroppableweaponobj != var_2) {
            if(var_5 != level.ref_11e18.setlastdroppableweaponobj && scripts\mp\gametypes\br_alt_mode_mxp::sat_computer_think_new() == 7) {
              var_7 = scripts\mp\gametypes\br_alt_mode_mxp::sandboxprintlinebold(var_1);
              var_8 = level.ref_11e18.setlethalonunresolvedcollision[var_7];
              var_9 = vectorNormalize(var_1.origin - var_6);
              var_10 = vectorNormalize(var_8 - var_1.origin);
              var_11 = vectordot(var_10, var_9);

              if(var_11 > getdvarfloat("scr_mxp_swim_angle_cos", 0.97)) {
                gcontinueswimtonext(var_1, var_8);
                continue;
              }
            }

            var_5 = level.ref_11e18.setlastdroppableweaponobj;
            var_6 = level.ref_11e18.setlethalonunresolvedcollision[var_5];
            scripts\mp\gametypes\br_alt_mode_mxp::set_relic_bang_and_boom(var_1);
            gstartandswimtonext(var_1);
          }
        }

        if(scripts\mp\gametypes\br_alt_mode_mxp::sat_computer_think_new() == 7) {
          scripts\mp\gametypes\br_alt_mode_mxp::set_relic_bang_and_boom(var_1);
          return;
        }
      }

      function gcontinueswimtonext(var_0, var_1) {
        scripts\mp\gametypes\br_alt_mode_mxp::set_maze_ai_stealth_settings(6);
        var_0 scripts\mp\gametypes\br_alt_mode_mxp::ref_13c1c("s4_mp_greenbay_swim_01");
        scripts\mp\gametypes\br_alt_mode_mxp::set_maze_ai_stealth_settings(6);
        thread scripts\mp\gametypes\br_alt_mode_mxp::gstatemovetorootmotion(var_0, var_1);

        while(scripts\mp\gametypes\br_alt_mode_mxp::sat_computer_think_new() != 7) {
          waitframe();
        }

        scripts\mp\gametypes\br_alt_mode_mxp::set_player_munition_currency(var_0);
      }

      function gstartandswimtonext(var_0) {
        scripts\mp\gametypes\br_alt_mode_mxp::set_relic_amped(var_0);

        while(scripts\mp\gametypes\br_alt_mode_mxp::sat_computer_think_new() != 7) {
          waitframe();
        }

        scripts\mp\gametypes\br_alt_mode_mxp::set_player_munition_currency(var_0);
      }

      function gwalkonpathtowardfrenzypoint(var_0) {
        scripts\mp\gametypes\br_alt_mode_mxp::set_relic_dogtags(var_0);
        gcompletemovetonextnode(var_0);
      }

      function getstepsanddir(var_0, var_1) {
        var_2 = level.ref_11e18.setlastdroppableweaponobj - var_1;
        var_3 = 0;

        if(abs(var_2) > 0) {
          var_4 = 0;
          var_5 = 0;

          if(var_2 > 0) {
            var_4 = var_2;
            var_5 = level.ref_11e18.setlethalonunresolvedcollision.size - level.ref_11e18.setlastdroppableweaponobj + var_1;
          } else {
            var_5 = 0 - var_2;
            var_4 = level.ref_11e18.setlethalonunresolvedcollision.size - var_1 + level.ref_11e18.setlastdroppableweaponobj;
          }

          var_2 = min(var_5, var_4);

          if(var_4 > var_5 && var_0.linked_mover) {
            var_3 = 1;
          } else if(var_5 > var_4 && !var_0.linked_mover) {
            var_3 = 1;
          }
        }

        return [var_2, var_3];
      }

      function gmoveoffpathtofrenzypoint(var_0, var_1) {
        var_2 = var_1 - var_0.origin;
        var_3 = vectortoangles(var_2);
        var_4 = angleclamp180(var_3[1]);
        scripts\mp\gametypes\br_alt_mode_mxp::set_relic_explodedmg(var_0, var_4, var_1);
        gstatemovetotarget(var_0, var_1);
        scripts\mp\gametypes\br_alt_mode_mxp::set_relic_doomslayer(var_0);

        if(isDefined(level.ref_11e18.—R ì = ×k· Ü½± - G4)) {
          var_5 = level.ref_11e18.—R ì = ×k· Ü½± - G4.origin;
          ref_11e19(var_0, var_5, &scripts\mp\gametypes\br_alt_mode_mxp::sat_activate);
        }

        scripts\mp\gametypes\br_alt_mode_mxp::set_maze_ai_stealth_settings(0);
      }

      function gheadtofrenzypoint(var_0) {
        var_1 = scripts\mp\gametypes\br_alt_mode_mxp::sat_computer_think_new();

        if(var_1 == 14 || var_1 == 15) {
          level.ref_11e18.wait_for_next_hack_complete notify("break_idle");
          scripts\mp\gametypes\br_alt_mode_mxp::set_maze_ai_stealth_settings(12);
        }

        gcompletemovetonextnode(var_0);
        var_2 = ggetsafepoint();
        var_3 = var_2[0];
        var_4 = var_2[1];
        var_2 = undefined;
        light_gz_monolith(var_4);
        gprogresstofrenzylocation(var_0, var_3, var_4);
      }

      function gcontinuewalktonextnode(var_0) {
        while(!scripts\mp\gametypes\br_alt_mode_mxp::score_event_kill(var_0)) {
          ganimatewalkwithoutovershooting(var_0);
        }

        scripts\mp\gametypes\br_alt_mode_mxp::set_relic_grounded(var_0, 12, 1);
        scripts\mp\gametypes\br_alt_mode_mxp::set_player_munition_currency(var_0);
      }

      function ganimatewalkwithoutovershooting(var_0) {
        thread gmonitorwalk(var_0);
        var_0 notify("gz_at_node");
        var_1 = var_0 scripts\mp\gametypes\br_alt_mode_mxp::ref_13c1c("s4_mp_greenbay_walk_01");
        var_2 = getanimlength(var_1);
        var_3 = var_0 scripts\engine\utility::waittill_notify_or_timeout_return("gz_at_node", var_2);
        var_0 notify("walk_cycle_done");
        return var_3 == "timeout";
      }

      function gmonitorwalk(var_0) {
        var_0 notify("goal_stopped");
        var_0 endon("goal_stopped");
        var_0 endon("walk_cycle_done");

        for(;;) {
          if(scripts\mp\gametypes\br_alt_mode_mxp::score_event_kill(var_0)) {
            var_0 notify("gz_at_node");
            return;
          }

          waitframe();
        }
      }

      function gstatemovetotarget(var_0, var_1) {
        var_0 endon("goal_reached");
        var_0 endon("goal_interrupted");
        scripts\mp\gametypes\br_alt_mode_mxp::set_maze_ai_stealth_settings(2);

        while(scripts\mp\gametypes\br_alt_mode_mxp::sat_computer_think_new() == 2) {
          gstatecontinuetotarget(var_0, var_1);
        }

        scripts\mp\gametypes\br_alt_mode_mxp::set_maze_ai_stealth_settings(12);
      }

      function gcompletemovetonextnode(var_0) {
        var_0 notify("goal_stopped");

        if(scripts\mp\gametypes\br_alt_mode_mxp::ginwalkingstate()) {
          gcontinuewalktonextnode(var_0);
        }

        for(var_1 = scripts\mp\gametypes\br_alt_mode_mxp::sat_computer_think_new(); var_1 == 6; var_1 = scripts\mp\gametypes\br_alt_mode_mxp::sat_computer_think_new()) {
          waitframe();
        }

        if(var_1 == 7) {
          scripts\mp\gametypes\br_alt_mode_mxp::set_player_munition_currency(var_0);

          if(getdvarint("disable_swim_to_frenzy", 0)) {
            scripts\mp\gametypes\br_alt_mode_mxp::set_relic_bang_and_boom(var_0);
            return;
          }

          return;
        }
      }

      function gstatecontinuetotarget(var_0, var_1) {
        var_0 endon("goal_reached");
        var_0 endon("goal_interrupted");
        thread gmonitortotarget(var_0, var_1);
        var_0 scripts\mp\gametypes\br_alt_mode_mxp::ref_13c1d("s4_mp_greenbay_walk_01");
        var_0 notify("walk_cycle_done");
      }

      function gmonitortotarget(var_0, var_1) {
        var_0 notify("goal_stopped");
        var_0 endon("goal_stopped");
        var_0 endon("walk_cycle_done");

        for(;;) {
          if(gisclosetofrenzypoint(var_0, var_1)) {
            var_0 notify("goal_reached");
            return;
          }

          waitframe();
        }
      }

      function gisclosetofrenzypoint(var_0, var_1) {
        var_2 = 100;
        var_3 = distance2d(var_1, var_0.origin);

        if(var_3 <= level.ref_11e18.ŽÅ _8šä Pªs) {
          return true;
        }

        var_4 = var_1 - var_0.origin;
        var_5 = var_0.angles;
        var_6 = anglesToForward(var_5);
        var_7 = vectordot(var_4, var_6);
        return var_7 <= 0;
      }

      function trunidlewait(var_0) {
        self notify("frenzy_event_ready");
        self endon("frenzy_event_ready");

        for(;;) {
          scripts\mp\gametypes\br_alt_mode_mxp::ref_13c1d(var_0);
        }
      }

      function set_dvars(var_0) {
        var_0 notify("frenzy_event_ready");
        var_0 scripts\mp\gametypes\br_alt_mode_mxp::tplayinterruptableanim("s4_mp_greenbay_idle_taunt_01");
      }

      function post_blockade_breadcrumb_struct(var_0) {
        if(level.ref_11e18.ref_13bef[var_0.agent_type] >= level.delayedeventtypes[16].secondwindthink) {
          if(istrue(var_0.„Û C ZJ[å()) {
                return 0;
              }

              var_0 thread scripts\mp\gametypes\br_publicevent_fresno::gz_onkilled(); var_0 scripts\mp\gametypes\br_alt_mode_mxp::ref_13c1d("s4_mp_greenbay_idle_staggered_01");
              return 0;
            }

            return scripts\mp\gametypes\br_publicevents::upload_station_interact_used_think(16);
          }

          function select_woods_two_spawners(var_0) {
            scripts\mp\gametypes\br_alt_mode_mxp::set_maze_ai_stealth_settings(0);
            var_1 = var_0.cashtorefund;
            var_2 = var_1 scripts\mp\gametypes\_mxp_target::play_players_arrive_at_extraction(var_1.radius);
            scripts\mp\gametypes\br_alt_mode_mxp::set_maze_ai_stealth_settings(13);
            ref_11e19(var_0, var_2, &scripts\mp\gametypes\br_alt_mode_mxp::sat_activate);
          }

          function send_munition_used_notify(var_0) {
            var_1 = getdvarint("scr_br_pe_fresno_frenzy_ideal_range_gz", 900);
            var_2 = var_0 scripts\mp\gametypes\br_publicevent_fresno::propspectating(var_1, level.ref_11e18.wait_for_next_hack_complete.ref_13f03);

            if(!isDefined(var_2)) {
              if(!var_0.ref_11ea7) {
                var_0 scripts\mp\gametypes\br_alt_mode_mxp::tplayinterruptableanim("s4_mp_greenbay_idle_lookaround_01");
                var_0.ref_11ea7 = 1;
                return;
              }

              gstateinterruptableidle(var_0);
              return;
            }

            if(isPlayer(var_2)) {
              var_0.ref_13f03 = var_2;
            } else if(isDefined(var_2.ºT° Í× c, ^ •' ) ) {
                var_0.ref_13f03 = var_2.ºT° Í× c, ^ •';
              }

              scripts\mp\gametypes\br_alt_mode_mxp::set_distances_for_groups(var_0); var_3 = scripts\mp\gametypes\br_alt_mode_mxp::randomizeattacklocation(var_2.origin, level.ref_11e18.‘·³æ[[–±6n Ž '¬ÂÚ“,‘ZÕÜ );
                    var_4 = scripts\mp\gametypes\br_public::semtex_used();
                    var_5 = scripts\mp\gametypes\br_public::modifyplayer_damage(var_3, abs(var_3[2]) + var_4);
                    var_6 = level.ref_11e18.šI 'óïûˆ2Š€Í%;(e Ýy#s < var_3[ 2 ] - var_5[ 2 ];

                    if(var_6) {
                      var_7 = vectortoangles(var_3 - var_0.origin);
                      _getrandomlocations::greenbaystrikeatpoint(var_3, var_7, level.ref_11e18.‘·³æ[[–±6n Ž '¬ÂÚ“,‘ZÕÜ );
                            }
                            else {
                              var_7 = vectortoangles(var_6 - var_1.origin);
                              _getrandomlocations::serverroomdogtagrevive(var_6, var_7, level.ref_11e18.‘·³æ[[–±6n Ž '¬ÂÚ“,‘ZÕÜ );
                                    }

                                    waitframe(); scripts\mp\gametypes\br_alt_mode_mxp::set_relic_grounded(var_1, 0, 0); scripts\mp\gametypes\br_alt_mode_mxp::set_relic_aggressive_melee_params(var_1); var_1.ref_13f03 = undefined;
                                  }

                                  function gstateinterruptableidle(var_0, var_1) {
                                    if(!isDefined(var_0.’K

                                        ¸ AÏ7 @µåx) || var_0.’K

                                      ¸ AÏ7 @µåx + 1 >= level.ref_11e18.¾w§ PX "Ö.size ) {
                                      var_0.’K

                                      ¸ AÏ7 @µåx = 0; var_0.—; - c¬ æ = scripts\engine\utility::array_randomize(level.ref_11e18.¾w§ PX "Ö );
                                      }
                                      else {
                                        var_0.’K

                                        ¸ AÏ7 @µåx++;
                                      }

                                      var_2 = var_0.’K

                                      ¸ AÏ7 @µåx; var_3 = var_0.—; - c¬ æ[var_2]; var_0 scripts\mp\gametypes\br_alt_mode_mxp::tplayinterruptableanim(var_3); var_0.nodeidle = 1;
                                    }

                                    function set_door_open(var_0) {
                                      disable_gz_monolith();
                                      var_1 = scripts\mp\gametypes\br_alt_mode_mxp::sandboxprintlinebold(var_0);
                                      var_2 = level.ref_11e18.setlethalonunresolvedcollision[var_1];
                                      ref_11e19(var_0, var_2, &scripts\mp\gametypes\br_alt_mode_mxp::sat_activate);
                                      scripts\mp\gametypes\br_alt_mode_mxp::set_maze_ai_stealth_settings(1);
                                      var_0 scripts\mp\gametypes\br_alt_mode_mxp::ref_13c1d("s4_mp_greenbay_walk_start_01");
                                      scripts\mp\gametypes\br_alt_mode_mxp::set_maze_ai_stealth_settings(2);
                                      var_0.chopper_carepackage = undefined;
                                      var_0.nodeidle = 1;
                                    }

                                    function gswimouttosea(var_0, var_1) {
                                      scripts\mp\gametypes\br_alt_mode_mxp::set_maze_ai_stealth_settings(5);
                                      var_0 scripts\mp\gametypes\br_alt_mode_mxp::ref_13c1d("s4_mp_greenbay_dive_01");
                                      scripts\mp\gametypes\br_alt_mode_mxp::set_maze_ai_stealth_settings(6);
                                      var_0 scripts\mp\gametypes\br_alt_mode_mxp::ref_13c1c("s4_mp_greenbay_swim_01");
                                      scripts\mp\gametypes\br_alt_mode_mxp::gstatemovetorootmotion(var_0, var_1);
                                    }

                                    function gstatecontinueswimming(var_0) {
                                      var_0 scripts\mp\gametypes\br_alt_mode_mxp::ref_13c1c("s4_mp_greenbay_swim_01");
                                      var_1 = scripts\mp\gametypes\br_alt_mode_mxp::sandboxprintlinebold(var_0);
                                      var_2 = level.ref_11e18.setlethalonunresolvedcollision[var_1];
                                      thread scripts\mp\gametypes\br_alt_mode_mxp::gstatemovetorootmotion(var_0, var_2);
                                    }

                                    function ggetsafepoint() {
                                      var_2 = level.ref_11e18.setincomingremovedcallback scripts\engine\utility::array_sort_with_func(getarraykeys(level.ref_11e18.seq3_tanksettings), &scripts\mp\gametypes\br_alt_mode_mxp::post_race);

                                      if(!isDefined(level.br_circle.dangercircleent)) {
                                        var_1 = level.ref_11e18.seq3_tanksettings[var_2[0]];
                                        return [var_1.score_event_civilian_killed, var_1.origin];
                                      }

                                      var_3 = min(6, var_1.size / 2);

                                      for(var_4 = 0; var_4 < var_3; var_4++) {
                                        var_5 = var_1[var_4];
                                        var_1 = level.ref_11e18.seq3_tanksettings[var_5];

                                        if(is_safe_point(var_1.origin)) {
                                          return [var_1.score_event_civilian_killed, var_1.origin];
                                        }
                                      }

                                      var_1 = level.ref_11e18.seq3_tanksettings[var_1[0]];
                                      return [var_1.score_event_civilian_killed, var_1.origin];
                                    }

                                    function is_safe_point(var_0) {
                                      if(istrue(level.br_circle_disabled)) {
                                        return true;
                                      }

                                      if(!isDefined(level.br_circle.dangercircleent) || !isDefined(level.br_circle.safecircleent)) {
                                        return false;
                                      }

                                      if(!scripts\mp\gametypes\br_circle::ispointincurrentsafecircle(var_0)) {
                                        return false;
                                      }

                                      if(scripts\mp\gametypes\br_circle::updatescavengerhud(var_0)) {
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
                                      var_0 = level.ref_11e18.wait_for_open;
                                      var_1 = level.ref_11e18.wait_for_open;

                                      for(var_2 = 0; var_2 < level.ref_11e18.wait_for_player_eliminated.size; var_2++) {
                                        var_0 = scripts\engine\utility::ter_op(var_0 + 1 < level.ref_11e18.wait_for_player_eliminated.size, var_0 + 1, 0);
                                        var_3 = level.ref_11e18.wait_for_player_eliminated[var_0];

                                        if(var_0 > 0 && level.ref_11e18.wait_for_open != var_0 && is_safe_point(var_3)) {
                                          return var_0;
                                        }

                                        var_1 = scripts\engine\utility::ter_op(var_1 > 0, var_1 - 1, level.ref_11e18.wait_for_player_eliminated.size - 1);
                                        var_4 = level.ref_11e18.wait_for_player_eliminated[var_1];

                                        if(var_1 > 0 && level.ref_11e18.wait_for_open != var_0 && is_safe_point(var_4)) {
                                          return var_1;
                                        }
                                      }
                                    }

                                    function ref_11e19(var_0, var_1) {
                                      var_2 = self.origin;
                                      var_3 = self.angles;
                                      var_4 = var_0 - var_2;
                                      var_5 = vectortoangles(var_4);
                                      var_6 = angleclamp180(var_5[1]);
                                      var_7 = angleclamp180(var_3[1]);
                                      var_8 = angleclamp180(var_6 - var_7);
                                      var_9 = [[var_1]](self, var_8);
                                      var_10 = var_9[0];
                                      var_11 = var_9[1];
                                      var_12 = var_9[2];
                                      var_9 = undefined;
                                      var_13 = 1;

                                      if(var_10 != "") {
                                        var_14 = scripts\mp\gametypes\br_alt_mode_mxp::tplayinterruptableanim(var_10);
                                      }

                                      self orientmode("face point", var_0);
                                      return var_13;
                                    }

                                    function light_kk_monolith(var_0) {
                                      var_1 = getentitylessscriptablearrayinradius("scriptable_lm_mkg_cliff_rock_06_kenosha", "classname");
                                      var_2 = undefined;
                                      var_3 = float(1e+10);

                                      foreach(var_5 in var_1) {
                                        var_6 = distancesquared(var_5.origin, var_0);

                                        if(var_6 < var_3) {
                                          var_3 = var_6;
                                          var_2 = var_5;
                                        }
                                      }

                                      if(isDefined(var_2)) {
                                        var_2 setscriptablepartstate("fx", "start");
                                      }

                                      level.ref_11e18.¬½ëÊ– Ï­­¢ Êð™ = var_2;
                                      level thread scripts\mp\gametypes\br_publicevent_fresno::attackerisinflictorforradiusexplosiveweapon(var_0, level.ref_11e18.wait_for_next_hack_complete);
                                    }

                                    function light_gz_monolith(var_0) {
                                      var_1 = getentitylessscriptablearrayinradius("scriptable_lm_mkg_cliff_rock_06_greenbay", "classname");
                                      var_2 = undefined;
                                      var_3 = float(1e+10);

                                      foreach(var_5 in var_1) {
                                        var_6 = distancesquared(var_5.origin, var_0);

                                        if(var_6 < var_3) {
                                          var_3 = var_6;
                                          var_2 = var_5;
                                        }
                                      }

                                      if(isDefined(var_2)) {
                                        var_2 setscriptablepartstate("fx", "start");
                                      }

                                      level.ref_11e18.—R ì = ×k· Ü½± - G4 = var_2;
                                      var_8 = getdvarfloat("scr_br_pe_fresno_gz_offset", 1.16667);
                                      var_9 = vectorNormalize(scripts\mp\gametypes\br_circle::getsafecircleorigin() - var_0);
                                      var_6 = level.ref_11e18.playerredeploy * var_8;
                                      var_10 = var_0 + var_9 * var_6;
                                      level thread scripts\mp\gametypes\br_publicevent_fresno::attackerisinflictorforradiusexplosiveweapon(var_10, level.ref_11e18.setincomingremovedcallback);
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