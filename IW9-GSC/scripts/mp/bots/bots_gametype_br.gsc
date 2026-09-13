/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_br.gsc
************************************************/

main() {
  if(_id_0A661C5FAD6BEDD8::_id_BC586652AA211EE1())
    [[level._id_37AA0062320EBD1A._id_91E547475C08DB07]]();
  else if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73()) {
    if(isDefined(level._id_7D43CCDC62F43DB3))
      [[level._id_7D43CCDC62F43DB3]]();
  } else if(scripts\mp\utility\game::getsubgametype() == "plunder" && _id_2CEDCC356F1B9FC8::isdmzbotpracticematch())
    [[level.dmz_bot_callback_func]]();
  else {
    setup_callbacks();
    setup_bot_br();
  }
}

setup_callbacks() {
  level.bot_funcs["player_spawned_gamemode"] = ::_id_543A0A3113FF89F7;
  level.bot_funcs["gametype_think"] = ::bot_br_think;
}

setup_bot_br() {
  setdvarifuninitialized("dvar_6EA9D854913F0E36", 0.25);
}

_id_543A0A3113FF89F7() {
  self botsetflag("ignore_nodes", 1);
}

bot_br_think() {
  self notify("bot_br_think");
  self endon("bot_br_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  _id_7DA10F5CA0899C16 = randomfloat(1) < getdvarfloat("dvar_6EA9D854913F0E36", 0.0);
  thread ammo_manager();

  for(;;) {
    if(_id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF() && !scripts\mp\flags::gameflag("graceperiod_done")) {
      self.ignoreall = 0;
      wait 0.05;
      continue;
    }

    if(isDefined(self.br_infil_type)) {
      if(_id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF() && !isDefined(self.infil_complete)) {
        self.ignoreall = 1;
        self botclearscriptgoal();
      }

      self botsetflag("disable_all_ai", 1);

      if((_id_2CEDCC356F1B9FC8::isplayerbrsquadleader() || _id_7DA10F5CA0899C16) && istrue(level.c130inbounds)) {
        _id_4FA3D43B222D0428 = _id_A4091EF2BE7E55B0();
        wait(_id_4FA3D43B222D0428);

        if(_id_2CEDCC356F1B9FC8::isplayerbrsquadleader())
          self notify("halo_jump_c130");
        else
          self notify("halo_jump_solo_c130");

        self.gulaguses = 1;

        if(getdvarint("dvar_3FF738F6200E3A65", 1) > 0)
          self.gulaguses = 0;

        self.jumped = 1;

        while(isDefined(self.br_infil_type))
          wait 0.05;
      }

      wait 0.05;
      continue;
    }

    if(_id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag()) {
      thread bot_gulag_think();
      self waittill("gulag_end");
      wait 3;
    } else
      self botclearscriptenemy();

    if(isDefined(level.br_circle) && isnavmeshloaded()) {
      _id_4CBD8AE83804749C = undefined;
      _id_F8CD7C50CE12C857 = self bothasscriptgoal();

      if(_id_F8CD7C50CE12C857)
        _id_4CBD8AE83804749C = self botgetscriptgoal();

      if(!scripts\mp\bots\bots_strategy::bot_has_tactical_goal() && !scripts\mp\bots\bots_util::bot_is_remote_or_linked()) {
        if((istrue(self isskydiving()) || istrue(self isparachuting())) && istrue(self.jumped) && istrue(_id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF())) {
          self botsetflag("disable_all_ai", 0);
          self botclearscriptgoal();
          bot_parachute_into_map();
        }

        if(_id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF() && !isDefined(self.infil_complete)) {
          self.ignoreall = 1;
          wait 1;
          continue;
        }

        _id_1C7C7A4EDF52593F = self botpathexists();
        _id_6E24445AC4C031BF = !_id_F8CD7C50CE12C857 || !_id_1C7C7A4EDF52593F || !_id_2695A20D4011076D::ispointincurrentsafecircle(_id_4CBD8AE83804749C);

        if(_id_F8CD7C50CE12C857) {
          distsq = distancesquared(self.origin, _id_4CBD8AE83804749C);
          goalradius = self botgetscriptgoalRadius();
          _id_0531B6F0C0441A69 = distsq < goalradius * goalradius;

          if(!_id_0531B6F0C0441A69)
            self.lasttimereachedscriptgoal = undefined;
          else if(!isDefined(self.lasttimereachedscriptgoal))
            self.lasttimereachedscriptgoal = gettime();
        }

        _id_7268D1B7D5E3BCDF = level.bot_personality_type[self.personality] == "stationary";

        if(isDefined(self.lasttimereachedscriptgoal)) {
          _id_1F511711D810114A = 0;

          if(_id_7268D1B7D5E3BCDF)
            _id_1F511711D810114A = 20000;

          _id_6E24445AC4C031BF = _id_6E24445AC4C031BF || gettime() - self.lasttimereachedscriptgoal >= _id_1F511711D810114A;
        }

        if(_id_6E24445AC4C031BF) {
          _id_7CB320786D438CCB = _id_2695A20D4011076D::getrandompointincurrentcircle();
          _id_5D3FE0FC4CE4A392 = self getclosestreachablepointonnavmesh(_id_7CB320786D438CCB);

          if(isDefined(_id_5D3FE0FC4CE4A392)) {
            self botsetscriptgoal(_id_5D3FE0FC4CE4A392, 1024, "hunt", undefined, undefined, !_id_7268D1B7D5E3BCDF);
            self.lasttimereachedscriptgoal = gettime();
          }
        }
      }
    } else
      scripts\mp\bots\bots_personality::update_personality_default();

    wait 0.05;
  }
}

_id_A4091EF2BE7E55B0() {
  _id_293FBE5226705D6F = level.br_ac130.origin;
  _id_11B7E7D7F8FB6A6D = vectorNormalize(level.infilstruct.c130pathstruct.endpt - _id_293FBE5226705D6F);
  _id_B4AF06317FCB3871 = (level.br_level.br_mapbounds[0][0] - _id_293FBE5226705D6F[0]) / _id_11B7E7D7F8FB6A6D[0];
  _id_B4D218317FF1A7BF = (level.br_level.br_mapbounds[0][1] - _id_293FBE5226705D6F[0]) / _id_11B7E7D7F8FB6A6D[0];
  _id_E659401CD955F3D8 = (level.br_level.br_mapbounds[0][1] - _id_293FBE5226705D6F[1]) / _id_11B7E7D7F8FB6A6D[1];
  _id_E67C561CD97C6BF2 = (level.br_level.br_mapbounds[1][1] - _id_293FBE5226705D6F[1]) / _id_11B7E7D7F8FB6A6D[1];
  _id_DD109C4F8BCC9684 = [_id_B4AF06317FCB3871, _id_B4D218317FF1A7BF, _id_E659401CD955F3D8, _id_E67C561CD97C6BF2];
  _id_858F6EE61AE10B78 = -1;

  foreach(_id_820FFEBF5EA17EF1 in _id_DD109C4F8BCC9684) {
    if(_id_820FFEBF5EA17EF1 > 0) {
      if(_id_858F6EE61AE10B78 < 0 || _id_820FFEBF5EA17EF1 < _id_858F6EE61AE10B78)
        _id_858F6EE61AE10B78 = _id_820FFEBF5EA17EF1;
    }
  }

  _id_544E266D9BC7FBC2 = _id_293FBE5226705D6F + _id_11B7E7D7F8FB6A6D * _id_858F6EE61AE10B78;
  _id_9F749890212A1229 = _id_45B2B4A889E633FA::getc130speed();
  _id_FDEFBFD6D1C30EA6 = _id_858F6EE61AE10B78 / _id_9F749890212A1229;
  return randomfloatrange(0.1, 0.9) * _id_FDEFBFD6D1C30EA6;
}

bot_parachute_into_map() {
  self endon("death_or_disconnect");
  self.ignoreall = 1;
  self.desired_landing_spot = bot_get_landing_spot();
  _id_5C8080B93191E9A4 = gettime() + randomfloatrange(5, 10) * 1000;
  _id_0EE69440F3C9F1E1 = 0;

  while(istrue(self isskydiving()) || istrue(self isparachuting())) {
    if(level.br_circle.circleindex > 0 && istrue(level.circleclosing) && !_id_2695A20D4011076D::ispointincurrentsafecircle(self.desired_landing_spot))
      self.desired_landing_spot = bot_get_landing_spot();

    _id_C23DD335AB7D9857 = bot_get_angles_to_goal(self, self.desired_landing_spot);
    speed = 1;
    _id_26555D95DC188E56 = self.desired_landing_spot - self getEye();

    if(_id_26555D95DC188E56[2] > 0 && vectordot(vectorNormalize(_id_26555D95DC188E56), (0, 0, 1)) > 0.939693)
      self.desired_landing_spot = self.origin - (0, 0, 100);

    self botlookatpoint(self.desired_landing_spot, 0.05, "script_forced");
    self botsetscriptmove(_id_C23DD335AB7D9857[1], 0.05, speed);

    if(gettime() > _id_5C8080B93191E9A4 && !_id_0EE69440F3C9F1E1) {
      self botpressbutton("jump", 1);
      _id_0EE69440F3C9F1E1 = 1;
    }

    wait 0.05;
  }

  self.infil_complete = 1;
  self botlookatpoint(undefined);
  self.ignoreall = 0;
  bot_go_to_destination();
}

bot_get_landing_spot(_id_026BA07CC43E5F46) {
  if(!isDefined(level.free_landing_spots) || level.free_landing_spots.size < 1) {
    level.free_landing_spots = _id_07580AE3D6694D93(level.bot_landing_spots);
    level.free_landing_spots = scripts\engine\utility::array_randomize(level.free_landing_spots);
  }

  if(isDefined(level.br_circle) && isnavmeshloaded()) {
    landing_spot = scripts\engine\utility::random(level.free_landing_spots);

    if(isDefined(landing_spot)) {
      _id_7CB320786D438CCB = landing_spot.origin;
      level.free_landing_spots = scripts\engine\utility::array_remove(level.free_landing_spots, landing_spot);
    } else
      _id_7CB320786D438CCB = _id_2695A20D4011076D::getrandompointincurrentcircle();

    return getclosestpointonnavmesh(_id_7CB320786D438CCB, self);
  }

  return undefined;
}

_id_07580AE3D6694D93(_id_D845B94E50A75D37) {
  radius = _id_2695A20D4011076D::getdangercircleradius();
  origin = _id_2695A20D4011076D::getdangercircleorigin();
  return scripts\engine\utility::get_array_of_closest(origin, _id_D845B94E50A75D37, undefined, undefined, radius);
}

bot_get_angles_to_goal(bot, _id_672F20A520D6C841) {
  _id_2D1D4D719DBC9554 = vectorNormalize(_id_672F20A520D6C841 - bot.origin);
  return vectortoangles(_id_2D1D4D719DBC9554);
}

bot_get_distance_to_goal(bot, _id_672F20A520D6C841) {
  return distance(bot.origin, _id_672F20A520D6C841);
}

bot_give_weapon() {
  if(!isDefined(level.bot_allowed_weapons))
    level.bot_allowed_weapons = ["iw8_sm_papa90_mp", "iw8_sh_charlie725_mp", "iw8_ar_akilo47_mp+acog", "iw8_lm_mgolf34_mp", "iw8_sn_kilo98_mp+scope", "iw8_sm_beta_mp+reflexmini2", "iw8_sm_augolf_mp+acog", "iw8_sm_mpapa7_mp+acog", "iw8_ar_falima_mp+reflexmini", "iw8_ar_kilo433_mp+acog", "iw8_ar_scharlie_mp+reflexmini2", "iw8_lm_lima86_mp+acog"];

  _id_BFDD5BCE24F4E213 = scripts\engine\utility::random(level.bot_allowed_weapons);

  switch (_id_BFDD5BCE24F4E213) {
    case "iw8_sh_charlie725_mp":
      if(!isDefined(level.bot_shotguns))
        level.bot_shotguns = 0;

      level.bot_shotguns++;

      if(level.bot_shotguns >= 1)
        level.bot_allowed_weapons = scripts\engine\utility::array_remove(level.bot_allowed_weapons, "iw8_sh_charlie725_mp");

      break;
    case "iw8_sn_kilo98_mp+scope":
      if(!isDefined(level.bot_snipers))
        level.bot_snipers = 0;

      level.bot_snipers++;

      if(level.bot_snipers >= 1)
        level.bot_allowed_weapons = scripts\engine\utility::array_remove(level.bot_allowed_weapons, "iw8_sn_kilo98_mp+scope");

      break;
  }

  weapon_obj = [[level.fnbuildweapon]]([[level.fngetweaponrootname]](_id_BFDD5BCE24F4E213), [], "none", "none", -1);
  self giveweapon(weapon_obj);
  self setweaponammoclip(weapon_obj, weaponclipsize(weapon_obj));
  self setweaponammostock(weapon_obj, weaponclipsize(weapon_obj));
  self switchtoweapon("none");
}

bot_go_to_destination() {
  self switchtoweapon("none");
  destination = get_destination_in_current_circle();

  if(!isDefined(destination)) {
    destination = spawnStruct();
    destination.origin = getrandompointinsafecirclenearby();
  }

  destination.claimed = 1;
  _id_7268D1B7D5E3BCDF = level.bot_personality_type[self.personality] == "stationary";
  self botsetscriptgoal(self getclosestreachablepointonnavmesh(destination.origin), 256, "guard", undefined, undefined, !_id_7268D1B7D5E3BCDF);
  scripts\engine\utility::waittill_any_2("goal", "last_stand_start");
  destination.claimed = undefined;

  if(!istrue(self.inlaststand))
    bot_give_weapon();

  bot_br_circle_think();
}

get_destination_in_current_circle() {
  destinations = _id_07580AE3D6694D93(level.bot_destination_spots);
  destinations = sortbydistance(destinations, self.origin);
  destination = get_closest_unclaimed_destination(destinations);

  if(!isDefined(destination))
    destination = get_closest_destination(destinations);

  return destination;
}

get_closest_unclaimed_destination(destinations) {
  foreach(destination in destinations) {
    if(!istrue(destination.claimed))
      return destination;
  }

  return undefined;
}

get_closest_destination(destinations) {
  return scripts\engine\utility::getclosest(self.origin, destinations);
}

bot_br_circle_think() {
  _id_7268D1B7D5E3BCDF = level.bot_personality_type[self.personality] == "stationary";
  _id_4098138536ED3870 = 0;

  for(;;) {
    _id_6B81B7B2626279EC = getrandompointincirclenearby();
    _id_4098138536ED3870 = bot_is_in_gas() || istrue(level.circleclosing);

    if(_id_4098138536ED3870)
      _id_6B81B7B2626279EC = getrandompointinsafecirclenearby();

    if(isDefined(_id_6B81B7B2626279EC)) {
      player_enemy = bot_get_player_enemy();

      if(istrue(level.bots_seek_player) && isDefined(player_enemy) && !_id_4098138536ED3870) {
        thread update_player_enemy_on_death();
        self getenemyinfo(player_enemy);

        if(self botgetpersonality() != "run_and_gun")
          scripts\mp\bots\bots_util::bot_set_personality("run_and_gun");

        if(self bothasscriptgoal())
          self botclearscriptgoal();

        if(!bot_has_player_enemy())
          _id_E858F82B38107A7C(player_enemy);
      } else {
        _id_6465D473E19215E3();

        if(self bothasscriptgoal())
          self botclearscriptgoal();

        if(_id_4098138536ED3870)
          self botsetscriptgoal(_id_6B81B7B2626279EC, 128, "critical", undefined, undefined, 0);
        else
          self botsetscriptgoal(_id_6B81B7B2626279EC, 400, "guard", undefined, undefined, 0);

        if(istrue(_id_4098138536ED3870))
          _id_4098138536ED3870 = 0;

        thread path_timeout();
        result = scripts\engine\utility::waittill_any_ents_return(self, "goal", self, "bad_path", level, "br_circle_started", self, "last_stand_start", self, "path_timeout");

        if(isDefined(result) && (result != "bad_path" && result != "br_circle_started" && result != "path_timeout" && result != "last_stand_start")) {
          _id_0CF1441229A2390C = gettime() + randomintrange(3, 8) * 1000;

          while(gettime() < _id_0CF1441229A2390C) {
            if(bot_is_in_gas()) {
              _id_6465D473E19215E3();
              break;
            }

            wait 0.1;
          }
        }
      }
    }

    wait 1;
  }
}

path_timeout() {
  self endon("last_stand_start");
  level endon("game_ended");
  self endon("goal");
  self endon("bad_path");
  level endon("br_circle_started");
  wait 15;
  self notify("path_timeout");
}

bot_gulag_think() {
  self endon("death_or_disconnect");
  self endon("gulag_end");
  level endon("game_ended");
  _id_7268D1B7D5E3BCDF = level.bot_personality_type[self.personality] == "stationary";
  _id_6465D473E19215E3(1);
  self.ignoreme = 1;
  self.ignoreall = 1;
  self botclearscriptgoal();

  while(!istrue(self.gulagarena))
    wait 1;

  self.ignoreme = 0;
  self.ignoreall = 0;
  scripts\mp\bots\bots_util::bot_set_personality("run_and_gun");

  for(;;) {
    arena = self.arena;

    if(isDefined(arena)) {
      foreach(player in arena.arenaplayers) {
        if(player == self) {
          continue;
        }
        if(istrue(arena.overtime) && isDefined(arena.dom) && isDefined(arena.dom.arenaflag) && isDefined(arena.dom.arenaflag.flagmodel)) {
          self botsetscriptgoal(arena.dom.arenaflag.flagmodel.origin, 64, "objective");
          self botclearscriptenemy();
          continue;
        }

        self getenemyinfo(player);
        self botsetscriptgoal(self getclosestreachablepointonnavmesh(player.origin), 256, "guard");

        if(self.team != player.team)
          self botsetscriptenemy(player);
      }
    }

    wait 3;
  }
}

ammo_manager(isdisabled) {
  self endon("death_or_disconnect");

  for(;;) {
    _id_BC9DA38A4BAB4CE2 = self getweaponslistprimaries();

    if(_id_BC9DA38A4BAB4CE2.size == 1 && _id_BC9DA38A4BAB4CE2[0].basename == "iw9_me_fists_mp" || isDefined(isdisabled) && self[[isdisabled]]()) {
      wait 1;
      continue;
    }

    foreach(weapon in _id_BC9DA38A4BAB4CE2) {
      if(self getweaponammostock(weapon) < weaponclipsize(weapon))
        self setweaponammostock(weapon, weaponclipsize(weapon));
    }

    wait 0.1;
  }
}

bot_get_player_enemy() {
  if(isDefined(level.player_enemy_cooldown) && gettime() <= level.player_enemy_cooldown)
    return undefined;

  player_enemy = get_player_enemy();

  if(!isDefined(player_enemy))
    return undefined;

  return player_enemy;
}

bots_with_player_enemy() {
  count = 0;

  foreach(bot in level.players) {
    if(!isbot(bot)) {
      continue;
    }
    if(bot bot_has_player_enemy())
      count++;
  }

  return count;
}

_id_E858F82B38107A7C(enemy) {
  self.player_enemy = enemy;
  self botsetscriptenemy(enemy);
}

_id_6465D473E19215E3(_id_C716028A11310807) {
  self.player_enemy = undefined;
  self botclearscriptenemy();

  if(!istrue(_id_C716028A11310807))
    self notify("update_on_death");
}

bot_has_player_enemy() {
  return isDefined(self.player_enemy);
}

get_player_enemy() {
  player_enemy = get_player();
  _id_41DC9E8631A11F9C = squared(3000);

  if(istrue(self.inlaststand) || _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag())
    return undefined;

  if(!isDefined(player_enemy) || istrue(player_enemy.inlaststand) || !isalive(player_enemy) || player_enemy _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag())
    return undefined;

  if(bot_is_in_gas())
    return undefined;

  _id_F39B75731AB66D7D = get_alive_bots();

  if(_id_F39B75731AB66D7D >= 3) {
    if(distancesquared(player_enemy.origin, self.origin) > _id_41DC9E8631A11F9C)
      return undefined;

    _id_A7F6DD4C7BFF569C = bots_with_player_enemy();

    if(bot_has_player_enemy())
      return player_enemy;

    if(_id_A7F6DD4C7BFF569C >= 1)
      return undefined;

    return player_enemy;
  } else
    return player_enemy;
}

get_player() {
  foreach(player in level.players) {
    if(!isbot(player))
      return player;
  }
}

update_player_enemy_on_death() {
  self notify("update_on_death");
  self endon("update_on_death");
  scripts\engine\utility::waittill_any_3("death", "death_or_disconnect", "last_stand_start");

  if(isDefined(self))
    _id_6465D473E19215E3(1);

  level.player_enemy_cooldown = gettime() + 7;
}

bot_is_in_gas() {
  if(!scripts\mp\flags::gameflag("graceperiod_done"))
    return 0;

  circleorigin = _id_2695A20D4011076D::getdangercircleorigin();
  circleradius = _id_2695A20D4011076D::getdangercircleradius();

  if(istrue(level.circleclosing)) {
    circleorigin = _id_2695A20D4011076D::getsafecircleorigin();
    circleradius = _id_2695A20D4011076D::getsafecircleradius();
  }

  if(_id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag())
    return 0;

  if(!isalive(self) || self.sessionstate != "playing")
    return 0;

  return !scripts\engine\utility::ispointinsidecircle(self.origin, circleorigin, circleradius);
}

getrandompointincirclewithindistance(maxdistance) {
  _id_7CB320786D438CCB = _id_2695A20D4011076D::getrandompointincurrentcircle();

  if(!isDefined(maxdistance))
    maxdistance = 1000;

  if(distance2d(self.origin, _id_7CB320786D438CCB) > maxdistance) {
    dir = vectortoangles(_id_7CB320786D438CCB - self.origin);
    fwd = anglesToForward(dir);
    _id_7CB320786D438CCB = self.origin + fwd * maxdistance;
  }

  return self getclosestreachablepointonnavmesh(_id_7CB320786D438CCB);
}

getrandompointinsafecirclenearby() {
  _id_ADD4FD7502A75A8A = _id_2695A20D4011076D::getsafecircleorigin();
  dist = _id_2695A20D4011076D::getsafecircleradius();
  _id_7CB320786D438CCB = _id_2695A20D4011076D::getrandompointincircle(_id_ADD4FD7502A75A8A, dist, 0.75, 0.9, 1, 1);
  return self getclosestreachablepointonnavmesh(_id_7CB320786D438CCB);
}

getrandompointincirclenearby() {
  timeout = gettime() + 5000;

  while(gettime() < timeout) {
    point = _id_2695A20D4011076D::getrandompointincircle(self.origin, 750, 0.6, 1, 1, 1);
    _id_03863887FED6F155 = self getclosestreachablepointonnavmesh(point);

    if(ispointincurrentcircle(_id_03863887FED6F155))
      return _id_03863887FED6F155;

    wait 0.05;
  }

  _id_7CB320786D438CCB = _id_2695A20D4011076D::getrandompointincurrentcircle();
  return self getclosestreachablepointonnavmesh(_id_7CB320786D438CCB);
}

ispointincurrentcircle(point) {
  circleorigin = _id_2695A20D4011076D::getdangercircleorigin();
  circleradius = _id_2695A20D4011076D::getdangercircleradius();
  return scripts\engine\utility::ispointinsidecircle(point, circleorigin, circleradius);
}

get_alive_bots() {
  _id_F39B75731AB66D7D = 0;

  foreach(player in level.players) {
    if(!isbot(player) || !isalive(player) || player.sessionstate != "playing") {
      continue;
    }
    _id_F39B75731AB66D7D++;
  }

  return _id_F39B75731AB66D7D;
}

botisonplayerteam(player) {
  _id_6A8F4E039C9A6EBF = level.teamdata[player.team]["alivePlayers"];

  if(scripts\engine\utility::array_contains(_id_6A8F4E039C9A6EBF, self))
    return 1;

  return 0;
}