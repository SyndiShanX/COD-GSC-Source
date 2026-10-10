/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\perks\perk_equipmentping.gsc
******************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#namespace perk_equipmentping;

function runequipmentping(ignore, lastpingtime) {
  if(!istrue(level.equipmentpingactive)) {
    return;
  }

  self endon("death");
  self.owner endon("disconnect");
  owner = self.owner;
  var_7fb1b202d80fb091 = level.uavsettings["uav_3dping"];

  if(!isDefined(lastpingtime)) {
    lastpingtime = 0;
  }

  self.equipping_lastpingtime = lastpingtime;

  if(owner _hasperk("specialty_equipment_ping")) {
    while(true) {
      shouldping = 0;

      if(gettime() >= self.equipping_lastpingtime + 3000) {
        pingplayers = utility::playersincylinder(self.origin, 300);

        foreach(player in pingplayers) {
          if(!isreallyalive(player)) {
            continue;
          }

          if(!owner scripts\cp_mp\utility\player_utility::isenemy(player)) {
            continue;
          }

          if(player _hasperk("specialty_location_marking")) {
            continue;
          }

          if(isDefined(player.outlined)) {
            continue;
          }

          contentignore = array_add(level.players, self);

          if(isDefined(ignore)) {
            contentignore = array_add(contentignore, ignore);
          }

          originoffset = self.origin + anglestoup(self.angles) * 10;

          if(ray_trace_passed(originoffset, player gettagorigin("j_head"), contentignore)) {
            if(!player _hasperk("specialty_gpsjammer")) {
              owner thread markasrelaysource(player);
            }

            shouldping = 1;
          }
        }

        if(shouldping) {
          if(!istrue(self.eyespyalerted)) {
            self.eyespyalerted = 1;
          }

          playfxontagforclients(var_7fb1b202d80fb091.fxid_ping, self, "tag_origin", owner);
          self playsoundtoplayer("ghost_senses_ping", owner);
          triggerportableradarping(self.origin, owner, 400, 800);
          wait 3;
        }
      }

      waitframe();
    }
  }
}

function markdangerzoneonminimap(target, equipment) {
  target endon("death_or_disconnect");

  if(!isDefined(target) || !isreallyalive(target)) {
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

function watchfordeath(objid) {
  self waittill("death_or_disconnect");
  scripts\mp\objidpoolmanager::returnobjectiveid(objid);
}

function markasrelaysource(otherplayer) {
  level endon("game_ended");
  self endon("disconnect");
  idx = otherplayer getentitynumber();

  if(!isDefined(self.relaysource)) {
    self.relaysource = [];
  } else if(isDefined(self.relaysource[idx])) {
    self notify("markAsRelaySource");
    self endon("markAsRelaySource");
  }

  self.relaysource[idx] = 1;
  otherplayer waittill_any_timeout_1(10, "death_or_disconnect");
  self.relaysource[idx] = 0;
}