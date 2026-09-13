/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1eb956cb30f1d423.gsc
***********************************************/

_id_CC07567B08D95292(_id_6DD492B76AE7D613) {
  _id_1491A51C2EF8B214 = scripts\engine\utility::getStructArray(_id_6DD492B76AE7D613, "targetname");

  foreach(area in _id_1491A51C2EF8B214)
  area thread _id_3B6CB5ADD3327A1B();
}

_id_3B6CB5ADD3327A1B() {
  trig = spawn("trigger_radius", self.origin, 0, int(self.radius), 1024);

  for(;;) {
    trig waittill("trigger", ent);

    if(!isPlayer(ent)) {
      continue;
    }
    break;
  }

  _id_CFF4CD4D39602AAE = scripts\engine\utility::getStructArray(self.target, "targetname");
  _id_0C3EA9B1A20FF199 = scripts\engine\utility::random(_id_CFF4CD4D39602AAE);
  _id_92753DA39919F200 = spawn("script_model", _id_0C3EA9B1A20FF199.origin);
  _id_92753DA39919F200.angles = _id_0C3EA9B1A20FF199.angles;
  _id_92753DA39919F200 setModel("misc_wm_mortar");
  _id_92753DA39919F200.script_noteworthy = "mortar";
  spawnpoint = scripts\engine\utility::getclosest(_id_0C3EA9B1A20FF199.origin, level._id_5A11797125800495);
  aitype = "actor_enemy_cp_rus_desert_smg";
  guys = [];
  guys[guys.size] = _id_537A712B2BE3193C::_id_43825E7633150BE3(aitype, spawnpoint, 0, 128);
  guys[guys.size] = _id_537A712B2BE3193C::_id_43825E7633150BE3(aitype, spawnpoint, 0, 128);

  foreach(guy in guys) {
    if(!isDefined(guy)) {
      continue;
    }
    if(!isDefined(_id_92753DA39919F200.operator))
      _id_92753DA39919F200.operator = guy;
    else {
      guy setgoalpos(_id_92753DA39919F200.origin);
      guy setgoalentity(_id_92753DA39919F200);
    }

    guy.entered_combat = 1;
  }

  _id_92753DA39919F200._id_4123FF32A76F808F = guys;
  level notify("mortar_team_spawned", _id_92753DA39919F200);
  level thread _id_230D6EEBDA212CCF(_id_92753DA39919F200, trig);
  _id_537A712B2BE3193C::_id_E4F3059610095250(guys);
  _id_92753DA39919F200 notify("stop_mortar_think");
  _id_92753DA39919F200 notify("stop_attracting");
  wait 3;
  _id_92753DA39919F200 playSound("sentry_explode");
  playFXOnTag(scripts\engine\utility::getfx("sentry_explode_mp"), _id_92753DA39919F200, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), _id_92753DA39919F200, "tag_aim");
  wait 1;
  _id_92753DA39919F200 delete();
}

_id_230D6EEBDA212CCF(_id_92753DA39919F200, trig) {
  _id_92753DA39919F200 endon("stop_mortar_think");
  level.get_mortar_impact_pos = ::_id_AA2345159B60A661;
  _id_92753DA39919F200.targets = undefined;

  for(;;) {
    targets = scripts\cp\utility::get_array_of_valid_players();
    targets = _id_9CB5E0B04644DD1A(trig);

    if(targets.size > 0) {
      _id_92753DA39919F200.targets = targets;
      _id_504283B70DE854FA::attract_agent_to_mortar(_id_92753DA39919F200, 1, 1024);
      _id_92753DA39919F200.targets = undefined;
      wait(randomintrange(5, 10));
      continue;
    }

    wait 1;
  }
}

_id_AA2345159B60A661(_id_92753DA39919F200) {
  if(!isDefined(_id_92753DA39919F200.targets))
    return undefined;

  player = scripts\engine\utility::random(_id_92753DA39919F200.targets);
  point = player.origin + (randomintrange(-10, 10), randomintrange(-10, 10), 0);
  trace = scripts\engine\trace::ray_trace(point + (0, 0, 500), point);
  return trace["position"];
}

_id_9CB5E0B04644DD1A(trig) {
  validplayers = [];

  foreach(player in level.players) {
    if(!player scripts\cp\utility::is_valid_player() || !player isonground() || player isonladder()) {
      continue;
    }
    if(player istouching(trig))
      validplayers[validplayers.size] = player;
  }

  return validplayers;
}