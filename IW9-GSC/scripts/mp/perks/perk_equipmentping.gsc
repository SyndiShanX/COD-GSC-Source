/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\perks\perk_equipmentping.gsc
***************************************************/

runequipmentping(ignore, _id_8B226FA0A4438980) {
  if(!istrue(level.equipmentpingactive)) {
    return;
  }
  self endon("death");
  self.owner endon("disconnect");
  owner = self.owner;
  _id_7FB1B202D80FB091 = level.uavsettings["uav_3dping"];

  if(!isDefined(_id_8B226FA0A4438980))
    _id_8B226FA0A4438980 = 0;

  self.equipping_lastpingtime = _id_8B226FA0A4438980;

  if(owner scripts\mp\utility\perk::_hasperk("specialty_equipment_ping")) {
    for(;;) {
      _id_8064F574A628C5EE = 0;

      if(gettime() >= self.equipping_lastpingtime + 3000) {
        pingplayers = scripts\common\utility::playersincylinder(self.origin, 300);

        foreach(player in pingplayers) {
          if(!scripts\mp\utility\player::isreallyalive(player)) {
            continue;
          }
          if(!owner scripts\cp_mp\utility\player_utility::isenemy(player)) {
            continue;
          }
          if(player scripts\mp\utility\perk::_hasperk("specialty_location_marking")) {
            continue;
          }
          if(isDefined(player.outlined)) {
            continue;
          }
          _id_FB1BC5065B2468D8 = scripts\engine\utility::array_add(level.players, self);

          if(isDefined(ignore))
            _id_FB1BC5065B2468D8 = scripts\engine\utility::array_add(_id_FB1BC5065B2468D8, ignore);

          _id_1E2F2224127D2990 = self.origin + anglestoup(self.angles) * 10;

          if(scripts\engine\trace::ray_trace_passed(_id_1E2F2224127D2990, player gettagorigin("j_head"), _id_FB1BC5065B2468D8)) {
            if(!player scripts\mp\utility\perk::_hasperk("specialty_gpsjammer"))
              owner thread markasrelaysource(player);

            _id_8064F574A628C5EE = 1;
          }
        }

        if(_id_8064F574A628C5EE) {
          if(!istrue(self.eyespyalerted))
            self.eyespyalerted = 1;

          playfxontagforclients(_id_7FB1B202D80FB091.fxid_ping, self, "tag_origin", owner);
          self playsoundtoplayer("ghost_senses_ping", owner);
          triggerportableradarping(self.origin, owner, 400, 800);
          wait 3;
        }
      }

      waitframe();
    }
  }
}

markdangerzoneonminimap(target, equipment) {
  target endon("death_or_disconnect");

  if(!isDefined(target) || !scripts\mp\utility\player::isreallyalive(target)) {
    return;
  }
  thread markasrelaysource(target);
  objid = scripts\mp\objidpoolmanager::requestobjectiveid(10);

  if(objid == -1) {
    return;
  }
  scripts\mp\objidpoolmanager::objective_add_objective(objid, "active", equipment.origin, "cb_compassping_eqp_ping", "icon_large");
  scripts\mp\objidpoolmanager::objective_playermask_single(objid, self);
  target thread watchfordeath(objid);
  wait 3;
  scripts\mp\objidpoolmanager::returnobjectiveid(objid);
}

watchfordeath(objid) {
  self waittill("death_or_disconnect");
  scripts\mp\objidpoolmanager::returnobjectiveid(objid);
}

markasrelaysource(_id_6EE5484560EC747C) {
  level endon("game_ended");
  self endon("disconnect");
  _id_FE8F7703F6313ED4 = _id_6EE5484560EC747C getentitynumber();

  if(!isDefined(self.relaysource))
    self.relaysource = [];
  else if(isDefined(self.relaysource[_id_FE8F7703F6313ED4])) {
    self notify("markAsRelaySource");
    self endon("markAsRelaySource");
  }

  self.relaysource[_id_FE8F7703F6313ED4] = 1;
  _id_6EE5484560EC747C scripts\engine\utility::waittill_any_timeout_1(10, "death_or_disconnect");
  self.relaysource[_id_FE8F7703F6313ED4] = 0;
}