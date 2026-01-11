/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_behavior.gsc
*************************************************/

#using scripts\shared\ai\archetype_locomotion_utility;
#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai\systems\animation_state_machine_mocomp;
#using scripts\shared\ai\systems\animation_state_machine_notetracks;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\zombie;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_attackables;
#using scripts\zm\_zm_behavior_utility;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#namespace zm_behavior;

function autoexec init() {
  initzmbehaviorsandasm();
  level.zigzag_activation_distance = 240;
  level.zigzag_distance_min = 240;
  level.zigzag_distance_max = 480;
  level.inner_zigzag_radius = 0;
  level.outer_zigzag_radius = 96;
}

function private initzmbehaviorsandasm() {
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieFindFleshService", &zombiefindflesh);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieEnteredPlayableService", &zombieenteredplayable);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieShouldMove", &shouldmovecondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieShouldTear", &zombieshouldtearcondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieShouldAttackThroughBoards", &zombieshouldattackthroughboardscondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieShouldTaunt", &zombieshouldtauntcondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieGotToEntrance", &zombiegottoentrancecondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieGotToAttackSpot", &zombiegottoattackspotcondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieHasAttackSpotAlready", &zombiehasattackspotalreadycondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieShouldEnterPlayable", &zombieshouldenterplayablecondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("isChunkValid", &ischunkvalidcondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("inPlayableArea", &inplayablearea);
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldSkipTeardown", &shouldskipteardown);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieIsThinkDone", &zombieisthinkdone);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieIsAtGoal", &zombieisatgoal);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieIsAtEntrance", &zombieisatentrance);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieShouldMoveAway", &zombieshouldmoveawaycondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("wasKilledByTesla", &waskilledbyteslacondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieShouldStun", &zombieshouldstun);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieIsBeingGrappled", &zombieisbeinggrappled);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieShouldKnockdown", &zombieshouldknockdown);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieIsPushed", &zombieispushed);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieKilledWhileGettingPulled", &zombiekilledwhilegettingpulled);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieKilledByBlackHoleBombCondition", &zombiekilledbyblackholebombcondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("disablePowerups", &disablepowerups);
  behaviortreenetworkutility::registerbehaviortreescriptapi("enablePowerups", &enablepowerups);
  behaviortreenetworkutility::registerbehaviortreeaction("zombieMoveToEntranceAction", &zombiemovetoentranceaction, undefined, &zombiemovetoentranceactionterminate);
  behaviortreenetworkutility::registerbehaviortreeaction("zombieMoveToAttackSpotAction", &zombiemovetoattackspotaction, undefined, &zombiemovetoattackspotactionterminate);
  behaviortreenetworkutility::registerbehaviortreeaction("zombieIdleAction", undefined, undefined, undefined);
  behaviortreenetworkutility::registerbehaviortreeaction("zombieMoveAway", &zombiemoveaway, undefined, undefined);
  behaviortreenetworkutility::registerbehaviortreeaction("zombieTraverseAction", &zombietraverseaction, undefined, &zombietraverseactionterminate);
  behaviortreenetworkutility::registerbehaviortreeaction("holdBoardAction", &zombieholdboardaction, undefined, &zombieholdboardactionterminate);
  behaviortreenetworkutility::registerbehaviortreeaction("grabBoardAction", &zombiegrabboardaction, undefined, &zombiegrabboardactionterminate);
  behaviortreenetworkutility::registerbehaviortreeaction("pullBoardAction", &zombiepullboardaction, undefined, &zombiepullboardactionterminate);
  behaviortreenetworkutility::registerbehaviortreeaction("zombieAttackThroughBoardsAction", &zombieattackthroughboardsaction, undefined, &zombieattackthroughboardsactionterminate);
  behaviortreenetworkutility::registerbehaviortreeaction("zombieTauntAction", &zombietauntaction, undefined, &zombietauntactionterminate);
  behaviortreenetworkutility::registerbehaviortreeaction("zombieMantleAction", &zombiemantleaction, undefined, &zombiemantleactionterminate);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieStunActionStart", &zombiestunactionstart);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieStunActionEnd", &zombiestunactionend);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieGrappleActionStart", &zombiegrappleactionstart);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieKnockdownActionStart", &zombieknockdownactionstart);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieGetupActionTerminate", &zombiegetupactionterminate);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombiePushedActionStart", &zombiepushedactionstart);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombiePushedActionTerminate", &zombiepushedactionterminate);
  behaviortreenetworkutility::registerbehaviortreeaction("zombieBlackHoleBombPullAction", &zombieblackholebombpullstart, &zombieblackholebombpullupdate, &zombieblackholebombpullend);
  behaviortreenetworkutility::registerbehaviortreeaction("zombieBlackHoleBombDeathAction", &zombiekilledbyblackholebombstart, undefined, &zombiekilledbyblackholebombend);
  behaviortreenetworkutility::registerbehaviortreescriptapi("getChunkService", &getchunkservice);
  behaviortreenetworkutility::registerbehaviortreescriptapi("updateChunkService", &updatechunkservice);
  behaviortreenetworkutility::registerbehaviortreescriptapi("updateAttackSpotService", &updateattackspotservice);
  behaviortreenetworkutility::registerbehaviortreescriptapi("findNodesService", &findnodesservice);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieAttackableObjectService", &zombieattackableobjectservice);
  animationstatenetwork::registeranimationmocomp("mocomp_board_tear@zombie", &boardtearmocompstart, &boardtearmocompupdate, undefined);
  animationstatenetwork::registeranimationmocomp("mocomp_barricade_enter@zombie", &barricadeentermocompstart, &barricadeentermocompupdate, &barricadeentermocompterminate);
  animationstatenetwork::registeranimationmocomp("mocomp_barricade_enter_no_z@zombie", &barricadeentermocompnozstart, &barricadeentermocompnozupdate, &barricadeentermocompnozterminate);
  animationstatenetwork::registernotetrackhandlerfunction("destroy_piece", &notetrackboardtear);
  animationstatenetwork::registernotetrackhandlerfunction("zombie_window_melee", &notetrackboardmelee);
  animationstatenetwork::registernotetrackhandlerfunction("bhb_burst", &zombiebhbburst);
  setdvar("scr_zm_use_code_enemy_selection", 1);
}

function zombiefindflesh(behaviortreeentity) {
  if(isDefined(behaviortreeentity.enablepushtime)) {
    if(gettime() >= behaviortreeentity.enablepushtime) {
      behaviortreeentity pushactors(1);
      behaviortreeentity.enablepushtime = undefined;
    }
  }
  if(getdvarint("scr_zm_use_code_enemy_selection", 0)) {
    zombiefindfleshcode(behaviortreeentity);
    return;
  }
  if(level.intermission) {
    return;
  }
  if(behaviortreeentity getpathmode() == "dont move") {
    return;
  }
  behaviortreeentity.ignoreme = 0;
  behaviortreeentity.ignore_player = [];
  behaviortreeentity.goalradius = 30;
  if(isDefined(behaviortreeentity.ignore_find_flesh) && behaviortreeentity.ignore_find_flesh) {
    return;
  }
  if(behaviortreeentity.team == "allies") {
    behaviortreeentity findzombieenemy();
    return;
  }
  if(zombieshouldmoveawaycondition(behaviortreeentity)) {
    return;
  }
  zombie_poi = behaviortreeentity zm_utility::get_zombie_point_of_interest(behaviortreeentity.origin);
  behaviortreeentity.zombie_poi = zombie_poi;
  players = getplayers();
  if(!isDefined(behaviortreeentity.ignore_player) || players.size == 1) {
    behaviortreeentity.ignore_player = [];
  } else if(!isDefined(level._should_skip_ignore_player_logic) || ![[level._should_skip_ignore_player_logic]]()) {
    i = 0;
    while(i < behaviortreeentity.ignore_player.size) {
      if(isDefined(behaviortreeentity.ignore_player[i]) && isDefined(behaviortreeentity.ignore_player[i].ignore_counter) && behaviortreeentity.ignore_player[i].ignore_counter > 3) {
        behaviortreeentity.ignore_player[i].ignore_counter = 0;
        behaviortreeentity.ignore_player = arrayremovevalue(behaviortreeentity.ignore_player, behaviortreeentity.ignore_player[i]);
        if(!isDefined(behaviortreeentity.ignore_player)) {
          behaviortreeentity.ignore_player = [];
        }
        i = 0;
        continue;
      }
      i++;
    }
  }
  behaviortreeentity zombie_utility::run_ignore_player_handler();
  player = zm_utility::get_closest_valid_player(behaviortreeentity.origin, behaviortreeentity.ignore_player);
  designated_target = 0;
  if(isDefined(player) && (isDefined(player.b_is_designated_target) && player.b_is_designated_target)) {
    designated_target = 1;
  }
  if(!isDefined(player) && !isDefined(zombie_poi) && !isDefined(behaviortreeentity.attackable)) {
    if(isDefined(behaviortreeentity.ignore_player)) {
      if(isDefined(level._should_skip_ignore_player_logic) && [[level._should_skip_ignore_player_logic]]()) {
        return;
      }
      behaviortreeentity.ignore_player = [];
    }
    if(isDefined(behaviortreeentity.ispuppet) && behaviortreeentity.ispuppet) {
      return;
    }
    if(isDefined(level.no_target_override)) {
      [
        [level.no_target_override]
      ](behaviortreeentity);
    } else {
      behaviortreeentity setgoal(behaviortreeentity.origin);
    }
    return;
  }
  if(!isDefined(level.check_for_alternate_poi) || ![[level.check_for_alternate_poi]]()) {
    behaviortreeentity.enemyoverride = zombie_poi;
    behaviortreeentity.favoriteenemy = player;
  }
  if(isDefined(behaviortreeentity.v_zombie_custom_goal_pos)) {
    goalpos = behaviortreeentity.v_zombie_custom_goal_pos;
    if(isDefined(behaviortreeentity.n_zombie_custom_goal_radius)) {
      behaviortreeentity.goalradius = behaviortreeentity.n_zombie_custom_goal_radius;
    }
    behaviortreeentity setgoal(goalpos);
  } else {
    if(isDefined(behaviortreeentity.enemyoverride) && isDefined(behaviortreeentity.enemyoverride[1])) {
      behaviortreeentity.has_exit_point = undefined;
      goalpos = behaviortreeentity.enemyoverride[0];
      if(!isDefined(zombie_poi)) {
        aiprofile_beginentry("zombiefindflesh-enemyoverride");
        queryresult = positionquery_source_navigation(goalpos, 0, 48, 36, 4);
        aiprofile_endentry();
        foreach(point in queryresult.data) {
          goalpos = point.origin;
          break;
        }
      }
      behaviortreeentity setgoal(goalpos);
    } else {
      if(isDefined(behaviortreeentity.attackable) && !designated_target) {
        if(isDefined(behaviortreeentity.attackable_slot)) {
          if(isDefined(behaviortreeentity.attackable_goal_radius)) {
            behaviortreeentity.goalradius = behaviortreeentity.attackable_goal_radius;
          }
          nav_mesh = getclosestpointonnavmesh(behaviortreeentity.attackable_slot.origin, 64);
          if(isDefined(nav_mesh)) {
            behaviortreeentity setgoal(nav_mesh);
          } else {
            behaviortreeentity setgoal(behaviortreeentity.attackable_slot.origin);
          }
        }
      } else if(isDefined(behaviortreeentity.favoriteenemy)) {
        behaviortreeentity.has_exit_point = undefined;
        behaviortreeentity.ignoreall = 0;
        if(isDefined(level.enemy_location_override_func)) {
          goalpos = [
            [level.enemy_location_override_func]
          ](behaviortreeentity, behaviortreeentity.favoriteenemy);
          if(isDefined(goalpos)) {
            behaviortreeentity setgoal(goalpos);
          } else {
            behaviortreeentity zombieupdategoal();
          }
        } else {
          if(isDefined(behaviortreeentity.is_rat_test) && behaviortreeentity.is_rat_test) {} else {
            if(zombieshouldmoveawaycondition(behaviortreeentity)) {} else if(isDefined(behaviortreeentity.favoriteenemy.last_valid_position)) {
              behaviortreeentity zombieupdategoal();
            }
          }
        }
      }
    }
  }
  if(players.size > 1) {
    else {}
    for(i = 0; i < behaviortreeentity.ignore_player.size; i++) {
      if(isDefined(behaviortreeentity.ignore_player[i])) {
        if(!isDefined(behaviortreeentity.ignore_player[i].ignore_counter)) {
          behaviortreeentity.ignore_player[i].ignore_counter = 0;
          continue;
        }
        behaviortreeentity.ignore_player[i].ignore_counter = behaviortreeentity.ignore_player[i].ignore_counter + 1;
      }
    }
  }
}

function zombiefindfleshcode(behaviortreeentity) {
  aiprofile_beginentry("zombieFindFleshCode");
  if(level.intermission) {
    aiprofile_endentry();
    return;
  }
  behaviortreeentity.ignore_player = [];
  behaviortreeentity.goalradius = 30;
  if(behaviortreeentity.team == "allies") {
    behaviortreeentity findzombieenemy();
    aiprofile_endentry();
    return;
  }
  if(level.wait_and_revive) {
    aiprofile_endentry();
    return;
  }
  if(level.zombie_poi_array.size > 0) {
    zombie_poi = behaviortreeentity zm_utility::get_zombie_point_of_interest(behaviortreeentity.origin);
  }
  behaviortreeentity zombie_utility::run_ignore_player_handler();
  zm_utility::update_valid_players(behaviortreeentity.origin, behaviortreeentity.ignore_player);
  if(!isDefined(behaviortreeentity.enemy) && !isDefined(zombie_poi)) {
    if(isDefined(behaviortreeentity.ispuppet) && behaviortreeentity.ispuppet) {
      aiprofile_endentry();
      return;
    }
    if(isDefined(level.no_target_override)) {
      [
        [level.no_target_override]
      ](behaviortreeentity);
    } else {
      behaviortreeentity setgoal(behaviortreeentity.origin);
    }
    aiprofile_endentry();
    return;
  }
  behaviortreeentity.enemyoverride = zombie_poi;
  if(isDefined(behaviortreeentity.enemyoverride) && isDefined(behaviortreeentity.enemyoverride[1])) {
    behaviortreeentity.has_exit_point = undefined;
    goalpos = behaviortreeentity.enemyoverride[0];
    queryresult = positionquery_source_navigation(goalpos, 0, 48, 36, 4);
    foreach(point in queryresult.data) {
      goalpos = point.origin;
      break;
    }
    behaviortreeentity setgoal(goalpos);
  } else if(isDefined(behaviortreeentity.enemy)) {
    behaviortreeentity.has_exit_point = undefined;
    if(isDefined(behaviortreeentity.is_rat_test) && behaviortreeentity.is_rat_test) {
      aiprofile_endentry();
      return;
    }
    if(isDefined(level.enemy_location_override_func)) {
      goalpos = [
        [level.enemy_location_override_func]
      ](behaviortreeentity, behaviortreeentity.enemy);
      if(isDefined(goalpos)) {
        behaviortreeentity setgoal(goalpos);
      } else {
        behaviortreeentity zombieupdategoalcode();
      }
    } else if(isDefined(behaviortreeentity.enemy.last_valid_position)) {
      behaviortreeentity zombieupdategoalcode();
    }
  }
  aiprofile_endentry();
}

function zombieupdategoal() {
  aiprofile_beginentry("zombieUpdateGoal");
  shouldrepath = 0;
  if(!shouldrepath && isDefined(self.favoriteenemy)) {
    if(!isDefined(self.nextgoalupdate) || self.nextgoalupdate <= gettime()) {
      shouldrepath = 1;
    } else {
      if(distancesquared(self.origin, self.favoriteenemy.origin) <= (level.zigzag_activation_distance * level.zigzag_activation_distance)) {
        shouldrepath = 1;
      } else if(isDefined(self.pathgoalpos)) {
        distancetogoalsqr = distancesquared(self.origin, self.pathgoalpos);
        shouldrepath = distancetogoalsqr < (72 * 72);
      }
    }
  }
  if(isDefined(level.validate_on_navmesh) && level.validate_on_navmesh) {
    if(!ispointonnavmesh(self.origin, self)) {
      shouldrepath = 0;
    }
  }
  if(isDefined(self.keep_moving) && self.keep_moving) {
    if(gettime() > self.keep_moving_time) {
      self.keep_moving = 0;
    }
  }
  if(shouldrepath) {
    goalpos = self.favoriteenemy.origin;
    if(isDefined(self.favoriteenemy.last_valid_position)) {
      goalpos = self.favoriteenemy.last_valid_position;
    }
    self setgoal(goalpos);
    should_zigzag = 1;
    if(isDefined(level.should_zigzag)) {
      should_zigzag = self[[level.should_zigzag]]();
    }
    if(isDefined(level.do_randomized_zigzag_path) && level.do_randomized_zigzag_path && should_zigzag) {
      if(distancesquared(self.origin, goalpos) > (level.zigzag_activation_distance * level.zigzag_activation_distance)) {
        self.keep_moving = 1;
        self.keep_moving_time = gettime() + 250;
        path = self calcapproximatepathtoposition(goalpos, 0);
        if(getdvarint("")) {
          for(index = 1; index < path.size; index++) {
            recordline(path[index - 1], path[index], (1, 0.5, 0), "", self);
          }
        }
        deviationdistance = randomintrange(level.zigzag_distance_min, level.zigzag_distance_max);
        if(isDefined(self.zigzag_distance_min) && isDefined(self.zigzag_distance_max)) {
          deviationdistance = randomintrange(self.zigzag_distance_min, self.zigzag_distance_max);
        }
        segmentlength = 0;
        for(index = 1; index < path.size; index++) {
          currentseglength = distance(path[index - 1], path[index]);
          if((segmentlength + currentseglength) > deviationdistance) {
            remaininglength = deviationdistance - segmentlength;
            seedposition = (path[index - 1]) + ((vectornormalize(path[index] - (path[index - 1]))) * remaininglength);
            recordcircle(seedposition, 2, (1, 0.5, 0), "", self);
            innerzigzagradius = level.inner_zigzag_radius;
            outerzigzagradius = level.outer_zigzag_radius;
            queryresult = positionquery_source_navigation(seedposition, innerzigzagradius, outerzigzagradius, 36, 16, self, 16);
            positionquery_filter_inclaimedlocation(queryresult, self);
            if(queryresult.data.size > 0) {
              point = queryresult.data[randomint(queryresult.data.size)];
              self setgoal(point.origin);
            }
            break;
          }
          segmentlength = segmentlength + currentseglength;
        }
      }
    }
    self.nextgoalupdate = gettime() + randomintrange(500, 1000);
  }
  aiprofile_endentry();
}

function zombieupdategoalcode() {
  aiprofile_beginentry("zombieUpdateGoalCode");
  shouldrepath = 0;
  if(!shouldrepath && isDefined(self.enemy)) {
    if(!isDefined(self.nextgoalupdate) || self.nextgoalupdate <= gettime()) {
      shouldrepath = 1;
    } else {
      if(distancesquared(self.origin, self.enemy.origin) <= (200 * 200)) {
        shouldrepath = 1;
      } else if(isDefined(self.pathgoalpos)) {
        distancetogoalsqr = distancesquared(self.origin, self.pathgoalpos);
        shouldrepath = distancetogoalsqr < (72 * 72);
      }
    }
  }
  if(isDefined(self.keep_moving) && self.keep_moving) {
    if(gettime() > self.keep_moving_time) {
      self.keep_moving = 0;
    }
  }
  if(shouldrepath) {
    goalpos = self.enemy.origin;
    if(isDefined(self.enemy.last_valid_position)) {
      goalpos = self.enemy.last_valid_position;
    }
    if(isDefined(level.do_randomized_zigzag_path) && level.do_randomized_zigzag_path) {
      if(distancesquared(self.origin, goalpos) > (240 * 240)) {
        self.keep_moving = 1;
        self.keep_moving_time = gettime() + 250;
        path = self calcapproximatepathtoposition(goalpos, 0);
        if(getdvarint("")) {
          for(index = 1; index < path.size; index++) {
            recordline(path[index - 1], path[index], (1, 0.5, 0), "", self);
          }
        }
        deviationdistance = randomintrange(240, 480);
        segmentlength = 0;
        for(index = 1; index < path.size; index++) {
          currentseglength = distance(path[index - 1], path[index]);
          if((segmentlength + currentseglength) > deviationdistance) {
            remaininglength = deviationdistance - segmentlength;
            seedposition = (path[index - 1]) + ((vectornormalize(path[index] - (path[index - 1]))) * remaininglength);
            recordcircle(seedposition, 2, (1, 0.5, 0), "", self);
            innerzigzagradius = level.inner_zigzag_radius;
            outerzigzagradius = level.outer_zigzag_radius;
            queryresult = positionquery_source_navigation(seedposition, innerzigzagradius, outerzigzagradius, 36, 16, self, 16);
            positionquery_filter_inclaimedlocation(queryresult, self);
            if(queryresult.data.size > 0) {
              point = queryresult.data[randomint(queryresult.data.size)];
              if(tracepassedonnavmesh(seedposition, point.origin, 16)) {
                goalpos = point.origin;
              }
            }
            break;
          }
          segmentlength = segmentlength + currentseglength;
        }
      }
    }
    self setgoal(goalpos);
    self.nextgoalupdate = gettime() + randomintrange(500, 1000);
  }
  aiprofile_endentry();
}

function zombieenteredplayable(behaviortreeentity) {
  if(!isDefined(level.playable_areas)) {
    level.playable_areas = getEntArray("player_volume", "script_noteworthy");
  }
  foreach(area in level.playable_areas) {
    if(behaviortreeentity istouching(area)) {
      behaviortreeentity zm_spawner::zombie_complete_emerging_into_playable_area();
      return true;
    }
  }
  return false;
}

function shouldmovecondition(behaviortreeentity) {
  if(behaviortreeentity haspath()) {
    return true;
  }
  if(isDefined(behaviortreeentity.keep_moving) && behaviortreeentity.keep_moving) {
    return true;
  }
  return false;
}

function zombieshouldmoveawaycondition(behaviortreeentity) {
  return level.wait_and_revive;
}

function waskilledbyteslacondition(behaviortreeentity) {
  if(isDefined(behaviortreeentity.tesla_death) && behaviortreeentity.tesla_death) {
    return true;
  }
  return false;
}

function disablepowerups(behaviortreeentity) {
  behaviortreeentity.no_powerups = 1;
}

function enablepowerups(behaviortreeentity) {
  behaviortreeentity.no_powerups = 0;
}

function zombiemoveaway(behaviortreeentity, asmstatename) {
  player = util::gethostplayer();
  queryresult = level.move_away_points;
  animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
  if(!isDefined(queryresult)) {
    return 5;
  }
  for(i = 0; i < queryresult.data.size; i++) {
    if(!zm_utility::check_point_in_playable_area(queryresult.data[i].origin)) {
      continue;
    }
    isbehind = vectordot(player.origin - behaviortreeentity.origin, queryresult.data[i].origin - behaviortreeentity.origin);
    if(isbehind < 0) {
      behaviortreeentity setgoal(queryresult.data[i].origin);
      arrayremoveindex(level.move_away_points.data, i, 0);
      i--;
      return 5;
    }
  }
  for(i = 0; i < queryresult.data.size; i++) {
    if(!zm_utility::check_point_in_playable_area(queryresult.data[i].origin)) {
      continue;
    }
    dist_zombie = distancesquared(queryresult.data[i].origin, behaviortreeentity.origin);
    dist_player = distancesquared(queryresult.data[i].origin, player.origin);
    if(dist_zombie < dist_player) {
      behaviortreeentity setgoal(queryresult.data[i].origin);
      arrayremoveindex(level.move_away_points.data, i, 0);
      i--;
      return 5;
    }
  }
  return 5;
}

function zombieisbeinggrappled(behaviortreeentity) {
  if(isDefined(behaviortreeentity.grapple_is_fatal) && behaviortreeentity.grapple_is_fatal) {
    return true;
  }
  return false;
}

function zombieshouldknockdown(behaviortreeentity) {
  if(isDefined(behaviortreeentity.knockdown) && behaviortreeentity.knockdown) {
    return true;
  }
  return false;
}

function zombieispushed(behaviortreeentity) {
  if(isDefined(behaviortreeentity.pushed) && behaviortreeentity.pushed) {
    return true;
  }
  return false;
}

function zombiegrappleactionstart(behaviortreeentity) {
  blackboard::setblackboardattribute(behaviortreeentity, "_grapple_direction", self.grapple_direction);
}

function private zombieknockdownactionstart(behaviortreeentity) {
  blackboard::setblackboardattribute(behaviortreeentity, "_knockdown_direction", behaviortreeentity.knockdown_direction);
  blackboard::setblackboardattribute(behaviortreeentity, "_knockdown_type", behaviortreeentity.knockdown_type);
  blackboard::setblackboardattribute(behaviortreeentity, "_getup_direction", behaviortreeentity.getup_direction);
}

function private zombiegetupactionterminate(behaviortreeentity) {
  behaviortreeentity.knockdown = 0;
}

function private zombiepushedactionstart(behaviortreeentity) {
  blackboard::setblackboardattribute(behaviortreeentity, "_push_direction", behaviortreeentity.push_direction);
}

function private zombiepushedactionterminate(behaviortreeentity) {
  behaviortreeentity.pushed = 0;
}

function zombieshouldstun(behaviortreeentity) {
  if(isDefined(behaviortreeentity.zombie_tesla_hit) && behaviortreeentity.zombie_tesla_hit && (!(isDefined(behaviortreeentity.tesla_death) && behaviortreeentity.tesla_death))) {
    return true;
  }
  return false;
}

function zombiestunactionstart(behaviortreeentity) {}

function zombiestunactionend(behaviortreeentity) {
  behaviortreeentity.zombie_tesla_hit = 0;
}

function zombietraverseaction(behaviortreeentity, asmstatename) {
  aiutility::traverseactionstart(behaviortreeentity, asmstatename);
  behaviortreeentity.old_powerups = behaviortreeentity.no_powerups;
  disablepowerups(behaviortreeentity);
  return 5;
}

function zombietraverseactionterminate(behaviortreeentity, asmstatename) {
  if(behaviortreeentity asmgetstatus() == "asm_status_complete") {
    behaviortreeentity.no_powerups = behaviortreeentity.old_powerups;
    if(!(isDefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs)) {
      behaviortreeentity pushactors(0);
      behaviortreeentity.enablepushtime = gettime() + 1000;
    }
  }
  return 4;
}

function zombiegottoentrancecondition(behaviortreeentity) {
  if(isDefined(behaviortreeentity.got_to_entrance) && behaviortreeentity.got_to_entrance) {
    return true;
  }
  return false;
}

function zombiegottoattackspotcondition(behaviortreeentity) {
  if(isDefined(behaviortreeentity.at_entrance_tear_spot) && behaviortreeentity.at_entrance_tear_spot) {
    return true;
  }
  return false;
}

function zombiehasattackspotalreadycondition(behaviortreeentity) {
  if(isDefined(behaviortreeentity.attacking_spot_index) && behaviortreeentity.attacking_spot_index >= 0) {
    return true;
  }
  return false;
}

function zombieshouldtearcondition(behaviortreeentity) {
  if(isDefined(behaviortreeentity.first_node) && isDefined(behaviortreeentity.first_node.barrier_chunks)) {
    if(!zm_utility::all_chunks_destroyed(behaviortreeentity.first_node, behaviortreeentity.first_node.barrier_chunks)) {
      return true;
    }
  }
  return false;
}

function zombieshouldattackthroughboardscondition(behaviortreeentity) {
  if(isDefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs) {
    return false;
  }
  if(isDefined(behaviortreeentity.first_node.zbarrier)) {
    if(!behaviortreeentity.first_node.zbarrier zbarriersupportszombiereachthroughattacks()) {
      chunks = undefined;
      if(isDefined(behaviortreeentity.first_node)) {
        chunks = zm_utility::get_non_destroyed_chunks(behaviortreeentity.first_node, behaviortreeentity.first_node.barrier_chunks);
      }
      if(isDefined(chunks) && chunks.size > 0) {
        return false;
      }
    }
  }
  if(getdvarstring("zombie_reachin_freq") == "") {
    setdvar("zombie_reachin_freq", "50");
  }
  freq = getdvarint("zombie_reachin_freq");
  players = getplayers();
  attack = 0;
  behaviortreeentity.player_targets = [];
  for(i = 0; i < players.size; i++) {
    if(isalive(players[i]) && !isDefined(players[i].revivetrigger) && distance2d(behaviortreeentity.origin, players[i].origin) <= 109.8 && (!(isDefined(players[i].zombie_vars["zombie_powerup_zombie_blood_on"]) && players[i].zombie_vars["zombie_powerup_zombie_blood_on"])) && (!(isDefined(players[i].ignoreme) && players[i].ignoreme))) {
      behaviortreeentity.player_targets[behaviortreeentity.player_targets.size] = players[i];
      attack = 1;
    }
  }
  if(!attack || freq < randomint(100)) {
    return false;
  }
  return true;
}

function zombieshouldtauntcondition(behaviortreeentity) {
  if(isDefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs) {
    return false;
  }
  if(!isDefined(behaviortreeentity.first_node.zbarrier)) {
    return false;
  }
  if(!behaviortreeentity.first_node.zbarrier zbarriersupportszombietaunts()) {
    return false;
  }
  if(getdvarstring("zombie_taunt_freq") == "") {
    setdvar("zombie_taunt_freq", "5");
  }
  freq = getdvarint("zombie_taunt_freq");
  if(freq >= randomint(100)) {
    return true;
  }
  return false;
}

function zombieshouldenterplayablecondition(behaviortreeentity) {
  if(isDefined(behaviortreeentity.first_node) && isDefined(behaviortreeentity.first_node.barrier_chunks)) {
    if(zm_utility::all_chunks_destroyed(behaviortreeentity.first_node, behaviortreeentity.first_node.barrier_chunks)) {
      if(isDefined(behaviortreeentity.at_entrance_tear_spot) && behaviortreeentity.at_entrance_tear_spot && (!(isDefined(behaviortreeentity.completed_emerging_into_playable_area) && behaviortreeentity.completed_emerging_into_playable_area))) {
        return true;
      }
    }
  }
  return false;
}

function ischunkvalidcondition(behaviortreeentity) {
  if(isDefined(behaviortreeentity.chunk)) {
    return true;
  }
  return false;
}

function inplayablearea(behaviortreeentity) {
  if(isDefined(behaviortreeentity.completed_emerging_into_playable_area) && behaviortreeentity.completed_emerging_into_playable_area) {
    return true;
  }
  return false;
}

function shouldskipteardown(behaviortreeentity) {
  if(behaviortreeentity zm_spawner::should_skip_teardown(behaviortreeentity.find_flesh_struct_string)) {
    return true;
  }
  return false;
}

function zombieisthinkdone(behaviortreeentity) {
  if(isDefined(behaviortreeentity.is_rat_test) && behaviortreeentity.is_rat_test) {
    return false;
  }
  if(isDefined(behaviortreeentity.zombie_think_done) && behaviortreeentity.zombie_think_done) {
    return true;
  }
  return false;
}

function zombieisatgoal(behaviortreeentity) {
  isatscriptgoal = behaviortreeentity isatgoal();
  return isatscriptgoal;
}

function zombieisatentrance(behaviortreeentity) {
  isatscriptgoal = behaviortreeentity isatgoal();
  isatentrance = isDefined(behaviortreeentity.first_node) && isatscriptgoal;
  return isatentrance;
}

function getchunkservice(behaviortreeentity) {
  behaviortreeentity.chunk = zm_utility::get_closest_non_destroyed_chunk(behaviortreeentity.origin, behaviortreeentity.first_node, behaviortreeentity.first_node.barrier_chunks);
  if(isDefined(behaviortreeentity.chunk)) {
    behaviortreeentity.first_node.zbarrier setzbarrierpiecestate(behaviortreeentity.chunk, "targetted_by_zombie");
    behaviortreeentity.first_node thread zm_spawner::check_zbarrier_piece_for_zombie_death(behaviortreeentity.chunk, behaviortreeentity.first_node.zbarrier, behaviortreeentity);
  }
}

function updatechunkservice(behaviortreeentity) {
  while(0 < behaviortreeentity.first_node.zbarrier.chunk_health[behaviortreeentity.chunk]) {
    behaviortreeentity.first_node.zbarrier.chunk_health[behaviortreeentity.chunk]--;
  }
  behaviortreeentity.lastchunk_destroy_time = gettime();
}

function updateattackspotservice(behaviortreeentity) {
  if(isDefined(behaviortreeentity.marked_for_death) && behaviortreeentity.marked_for_death || behaviortreeentity.health < 0) {
    return false;
  }
  if(!isDefined(behaviortreeentity.attacking_spot)) {
    if(!behaviortreeentity zm_spawner::get_attack_spot(behaviortreeentity.first_node)) {
      return false;
    }
  }
  if(isDefined(behaviortreeentity.attacking_spot)) {
    behaviortreeentity.goalradius = 8;
    behaviortreeentity setgoal(behaviortreeentity.attacking_spot);
    if(behaviortreeentity isatgoal()) {
      behaviortreeentity.at_entrance_tear_spot = 1;
    }
    return true;
  }
  return false;
}

function findnodesservice(behaviortreeentity) {
  node = undefined;
  behaviortreeentity.entrance_nodes = [];
  if(isDefined(behaviortreeentity.find_flesh_struct_string)) {
    if(behaviortreeentity.find_flesh_struct_string == "find_flesh") {
      return false;
    }
    for(i = 0; i < level.exterior_goals.size; i++) {
      if(isDefined(level.exterior_goals[i].script_string) && level.exterior_goals[i].script_string == behaviortreeentity.find_flesh_struct_string) {
        node = level.exterior_goals[i];
        break;
      }
    }
    behaviortreeentity.entrance_nodes[behaviortreeentity.entrance_nodes.size] = node;
    assert(isDefined(node), ("" + behaviortreeentity.find_flesh_struct_string) + "");
    behaviortreeentity.first_node = node;
    behaviortreeentity.goalradius = 128;
    behaviortreeentity setgoal(node.origin);
    if(zombieisatentrance(behaviortreeentity)) {
      behaviortreeentity.got_to_entrance = 1;
    }
    return true;
  }
}

function zombieattackableobjectservice(behaviortreeentity) {
  if(!behaviortreeentity ai::has_behavior_attribute("use_attackable") || !behaviortreeentity ai::get_behavior_attribute("use_attackable")) {
    behaviortreeentity.attackable = undefined;
    return false;
  }
  if(isDefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs) {
    behaviortreeentity.attackable = undefined;
    return false;
  }
  if(isDefined(behaviortreeentity.aat_turned) && behaviortreeentity.aat_turned) {
    behaviortreeentity.attackable = undefined;
    return false;
  }
  if(!isDefined(behaviortreeentity.attackable)) {
    behaviortreeentity.attackable = zm_attackables::get_attackable();
  } else if(!(isDefined(behaviortreeentity.attackable.is_active) && behaviortreeentity.attackable.is_active)) {
    behaviortreeentity.attackable = undefined;
  }
}

function zombiemovetoentranceaction(behaviortreeentity, asmstatename) {
  behaviortreeentity.got_to_entrance = 0;
  animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
  return 5;
}

function zombiemovetoentranceactionterminate(behaviortreeentity, asmstatename) {
  if(zombieisatentrance(behaviortreeentity)) {
    behaviortreeentity.got_to_entrance = 1;
  }
  return 4;
}

function zombiemovetoattackspotaction(behaviortreeentity, asmstatename) {
  behaviortreeentity.at_entrance_tear_spot = 0;
  animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
  return 5;
}

function zombiemovetoattackspotactionterminate(behaviortreeentity, asmstatename) {
  behaviortreeentity.at_entrance_tear_spot = 1;
  return 4;
}

function zombieholdboardaction(behaviortreeentity, asmstatename) {
  behaviortreeentity.keepclaimednode = 1;
  blackboard::setblackboardattribute(behaviortreeentity, "_which_board_pull", int(behaviortreeentity.chunk));
  blackboard::setblackboardattribute(behaviortreeentity, "_board_attack_spot", float(behaviortreeentity.attacking_spot_index));
  boardactionast = behaviortreeentity astsearch(istring(asmstatename));
  boardactionanimation = animationstatenetworkutility::searchanimationmap(behaviortreeentity, boardactionast["animation"]);
  animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
  return 5;
}

function zombieholdboardactionterminate(behaviortreeentity, asmstatename) {
  behaviortreeentity.keepclaimednode = 0;
  return 4;
}

function zombiegrabboardaction(behaviortreeentity, asmstatename) {
  behaviortreeentity.keepclaimednode = 1;
  blackboard::setblackboardattribute(behaviortreeentity, "_which_board_pull", int(behaviortreeentity.chunk));
  blackboard::setblackboardattribute(behaviortreeentity, "_board_attack_spot", float(behaviortreeentity.attacking_spot_index));
  boardactionast = behaviortreeentity astsearch(istring(asmstatename));
  boardactionanimation = animationstatenetworkutility::searchanimationmap(behaviortreeentity, boardactionast["animation"]);
  animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
  return 5;
}

function zombiegrabboardactionterminate(behaviortreeentity, asmstatename) {
  behaviortreeentity.keepclaimednode = 0;
  return 4;
}

function zombiepullboardaction(behaviortreeentity, asmstatename) {
  behaviortreeentity.keepclaimednode = 1;
  blackboard::setblackboardattribute(behaviortreeentity, "_which_board_pull", int(behaviortreeentity.chunk));
  blackboard::setblackboardattribute(behaviortreeentity, "_board_attack_spot", float(behaviortreeentity.attacking_spot_index));
  boardactionast = behaviortreeentity astsearch(istring(asmstatename));
  boardactionanimation = animationstatenetworkutility::searchanimationmap(behaviortreeentity, boardactionast["animation"]);
  animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
  return 5;
}

function zombiepullboardactionterminate(behaviortreeentity, asmstatename) {
  behaviortreeentity.keepclaimednode = 0;
  self.lastchunk_destroy_time = gettime();
  return 4;
}

function zombieattackthroughboardsaction(behaviortreeentity, asmstatename) {
  behaviortreeentity.keepclaimednode = 1;
  behaviortreeentity.boardattack = 1;
  animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
  return 5;
}

function zombieattackthroughboardsactionterminate(behaviortreeentity, asmstatename) {
  behaviortreeentity.keepclaimednode = 0;
  behaviortreeentity.boardattack = 0;
  return 4;
}

function zombietauntaction(behaviortreeentity, asmstatename) {
  behaviortreeentity.keepclaimednode = 1;
  animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
  return 5;
}

function zombietauntactionterminate(behaviortreeentity, asmstatename) {
  behaviortreeentity.keepclaimednode = 0;
  return 4;
}

function zombiemantleaction(behaviortreeentity, asmstatename) {
  behaviortreeentity.clamptonavmesh = 0;
  if(isDefined(behaviortreeentity.attacking_spot_index)) {
    behaviortreeentity.saved_attacking_spot_index = behaviortreeentity.attacking_spot_index;
    blackboard::setblackboardattribute(behaviortreeentity, "_board_attack_spot", float(behaviortreeentity.attacking_spot_index));
  }
  behaviortreeentity.isinmantleaction = 1;
  behaviortreeentity zombie_utility::reset_attack_spot();
  animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
  return 5;
}

function zombiemantleactionterminate(behaviortreeentity, asmstatename) {
  behaviortreeentity.clamptonavmesh = 1;
  behaviortreeentity.isinmantleaction = undefined;
  behaviortreeentity zm_behavior_utility::enteredplayablearea();
  return 4;
}

function boardtearmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  origin = getstartorigin(entity.first_node.zbarrier.origin, entity.first_node.zbarrier.angles, mocompanim);
  angles = getstartangles(entity.first_node.zbarrier.origin, entity.first_node.zbarrier.angles, mocompanim);
  entity forceteleport(origin, angles, 1);
  entity.pushable = 0;
  entity.blockingpain = 1;
  entity animmode("noclip", 1);
  entity orientmode("face angle", angles[1]);
}

function boardtearmocompupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity animmode("noclip", 0);
  entity.pushable = 0;
  entity.blockingpain = 1;
}

function barricadeentermocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  origin = getstartorigin(entity.first_node.zbarrier.origin, entity.first_node.zbarrier.angles, mocompanim);
  angles = getstartangles(entity.first_node.zbarrier.origin, entity.first_node.zbarrier.angles, mocompanim);
  if(isDefined(entity.mocomp_barricade_offset)) {
    origin = origin + (anglesToForward(angles) * entity.mocomp_barricade_offset);
  }
  entity forceteleport(origin, angles, 1);
  entity animmode("noclip", 0);
  entity orientmode("face angle", angles[1]);
  entity.pushable = 0;
  entity.blockingpain = 1;
  entity pathmode("dont move");
  entity.usegoalanimweight = 1;
}

function barricadeentermocompupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity animmode("noclip", 0);
  entity.pushable = 0;
}

function barricadeentermocompterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity.pushable = 1;
  entity.blockingpain = 0;
  entity pathmode("move allowed");
  entity.usegoalanimweight = 0;
  entity animmode("normal", 0);
  entity orientmode("face motion");
}

function barricadeentermocompnozstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  zbarrier_origin = (entity.first_node.zbarrier.origin[0], entity.first_node.zbarrier.origin[1], entity.origin[2]);
  origin = getstartorigin(zbarrier_origin, entity.first_node.zbarrier.angles, mocompanim);
  angles = getstartangles(zbarrier_origin, entity.first_node.zbarrier.angles, mocompanim);
  if(isDefined(entity.mocomp_barricade_offset)) {
    origin = origin + (anglesToForward(angles) * entity.mocomp_barricade_offset);
  }
  entity forceteleport(origin, angles, 1);
  entity animmode("noclip", 0);
  entity orientmode("face angle", angles[1]);
  entity.pushable = 0;
  entity.blockingpain = 1;
  entity pathmode("dont move");
  entity.usegoalanimweight = 1;
}

function barricadeentermocompnozupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity animmode("noclip", 0);
  entity.pushable = 0;
}

function barricadeentermocompnozterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity.pushable = 1;
  entity.blockingpain = 0;
  entity pathmode("move allowed");
  entity.usegoalanimweight = 0;
  entity animmode("normal", 0);
  entity orientmode("face motion");
}

function notetrackboardtear(animationentity) {
  if(isDefined(animationentity.chunk)) {
    animationentity.first_node.zbarrier setzbarrierpiecestate(animationentity.chunk, "opening");
  }
}

function notetrackboardmelee(animationentity) {
  assert(animationentity.meleeweapon != level.weaponnone, "");
  if(isDefined(animationentity.first_node)) {
    meleedistsq = 8100;
    if(isDefined(level.attack_player_thru_boards_range)) {
      meleedistsq = level.attack_player_thru_boards_range * level.attack_player_thru_boards_range;
    }
    triggerdistsq = 2601;
    for(i = 0; i < animationentity.player_targets.size; i++) {
      playerdistsq = distance2dsquared(animationentity.player_targets[i].origin, animationentity.origin);
      heightdiff = abs(animationentity.player_targets[i].origin[2] - animationentity.origin[2]);
      if(playerdistsq < meleedistsq && (heightdiff * heightdiff) < meleedistsq) {
        playertriggerdistsq = distance2dsquared(animationentity.player_targets[i].origin, animationentity.first_node.trigger_location.origin);
        heightdiff = abs(animationentity.player_targets[i].origin[2] - animationentity.first_node.trigger_location.origin[2]);
        if(playertriggerdistsq < triggerdistsq && (heightdiff * heightdiff) < triggerdistsq) {
          animationentity.player_targets[i] dodamage(animationentity.meleeweapon.meleedamage, animationentity.origin, self, self, "none", "MOD_MELEE");
          break;
        }
      }
    }
  } else {
    animationentity melee();
  }
}

function findzombieenemy() {
  zombies = getaispeciesarray(level.zombie_team, "all");
  zombie_enemy = undefined;
  closest_dist = undefined;
  foreach(zombie in zombies) {
    if(isalive(zombie) && (isDefined(zombie.completed_emerging_into_playable_area) && zombie.completed_emerging_into_playable_area) && !zm_utility::is_magic_bullet_shield_enabled(zombie) && (zombie.archetype == "zombie" || (isDefined(zombie.canbetargetedbyturnedzombies) && zombie.canbetargetedbyturnedzombies))) {
      dist = distancesquared(self.origin, zombie.origin);
      if(!isDefined(closest_dist) || dist < closest_dist) {
        closest_dist = dist;
        zombie_enemy = zombie;
      }
    }
  }
  self.favoriteenemy = zombie_enemy;
  if(isDefined(self.favoriteenemy)) {
    self setgoal(self.favoriteenemy.origin);
  } else {
    self setgoal(self.origin);
  }
}

function zombieblackholebombpullstart(entity, asmstatename) {
  entity.pulltime = gettime();
  entity.pullorigin = entity.origin;
  animationstatenetworkutility::requeststate(entity, asmstatename);
  zombieupdateblackholebombpullstate(entity);
  if(isDefined(entity.damageorigin)) {
    entity.n_zombie_custom_goal_radius = 8;
    entity.v_zombie_custom_goal_pos = entity.damageorigin;
  }
  return 5;
}

function zombieupdateblackholebombpullstate(entity) {
  dist_to_bomb = distancesquared(entity.origin, entity.damageorigin);
  if(dist_to_bomb < 16384) {
    entity._black_hole_bomb_collapse_death = 1;
  } else {
    if(dist_to_bomb < 1048576) {
      blackboard::setblackboardattribute(entity, "_zombie_blackholebomb_pull_state", "bhb_pull_fast");
    } else if(dist_to_bomb < 4227136) {
      blackboard::setblackboardattribute(entity, "_zombie_blackholebomb_pull_state", "bhb_pull_slow");
    }
  }
}

function zombieblackholebombpullupdate(entity, asmstatename) {
  if(!isDefined(entity.interdimensional_gun_kill)) {
    return 4;
  }
  zombieupdateblackholebombpullstate(entity);
  if(isDefined(entity._black_hole_bomb_collapse_death) && entity._black_hole_bomb_collapse_death) {
    entity.skipautoragdoll = 1;
    entity dodamage(entity.health + 666, entity.origin + vectorscale((0, 0, 1), 50), entity.interdimensional_gun_attacker, undefined, undefined, "MOD_CRUSH");
    return 4;
  }
  if(isDefined(entity.damageorigin)) {
    entity.v_zombie_custom_goal_pos = entity.damageorigin;
  }
  if(!(isDefined(entity.missinglegs) && entity.missinglegs) && (gettime() - entity.pulltime) > 1000) {
    distsq = distance2dsquared(entity.origin, entity.pullorigin);
    if(distsq < 144) {
      entity setavoidancemask("avoid all");
      entity.cant_move = 1;
      if(isDefined(entity.cant_move_cb)) {
        entity[[entity.cant_move_cb]]();
      }
    } else {
      entity setavoidancemask("avoid none");
      entity.cant_move = 0;
    }
    entity.pulltime = gettime();
    entity.pullorigin = entity.origin;
  }
  return 5;
}

function zombieblackholebombpullend(entity, asmstatename) {
  entity.v_zombie_custom_goal_pos = undefined;
  entity.n_zombie_custom_goal_radius = undefined;
  entity.pulltime = undefined;
  entity.pullorigin = undefined;
  return 4;
}

function zombiekilledwhilegettingpulled(entity) {
  if(!(isDefined(self.missinglegs) && self.missinglegs) && (isDefined(entity.interdimensional_gun_kill) && entity.interdimensional_gun_kill) && (!(isDefined(entity._black_hole_bomb_collapse_death) && entity._black_hole_bomb_collapse_death))) {
    return true;
  }
  return false;
}

function zombiekilledbyblackholebombcondition(entity) {
  if(isDefined(entity._black_hole_bomb_collapse_death) && entity._black_hole_bomb_collapse_death) {
    return true;
  }
  return false;
}

function zombiekilledbyblackholebombstart(entity, asmstatename) {
  animationstatenetworkutility::requeststate(entity, asmstatename);
  if(isDefined(level.black_hole_bomb_death_start_func)) {
    entity thread[[level.black_hole_bomb_death_start_func]](entity.damageorigin, entity.interdimensional_gun_projectile);
  }
  return 5;
}

function zombiekilledbyblackholebombend(entity, asmstatename) {
  if(isDefined(level._effect) && isDefined(level._effect["black_hole_bomb_zombie_gib"])) {
    fxorigin = entity gettagorigin("tag_origin");
    forward = anglesToForward(entity.angles);
    playFX(level._effect["black_hole_bomb_zombie_gib"], fxorigin, forward, (0, 0, 1));
  }
  entity hide();
  return 4;
}

function zombiebhbburst(entity) {
  if(isDefined(level._effect) && isDefined(level._effect["black_hole_bomb_zombie_destroy"])) {
    fxorigin = entity gettagorigin("tag_origin");
    playFX(level._effect["black_hole_bomb_zombie_destroy"], fxorigin);
  }
  if(isDefined(entity.interdimensional_gun_projectile)) {
    entity.interdimensional_gun_projectile notify("black_hole_bomb_kill");
  }
}