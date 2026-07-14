/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\minimap.gsc
**************************************/

#using scripts\common\vehicle;
#namespace minimap;

function trigger_set_floor(ent, setfunc, minimap_floor, var_5269d98756c2f039) {
  if(!isPlayer(ent) && !ent vehicle::is_vehicle()) {
    return;
  }

  assert(isthreaded());
  assert(isent(self));
  assert(isfunction(setfunc));
  triggernum = self getentitynumber();
  entnum = ent getentitynumber();
  var_1b82d683e0c151da = "trigger_set_floor_" + entnum + "_" + triggernum;
  ent endon("death_or_disconnect");
  self endon("death_or_disconnect");
  self notify(var_1b82d683e0c151da);
  self endon(var_1b82d683e0c151da);
  ent.var_4bdc8a1a86868e9[triggernum] = self;

  for(firstkey = getfirstarraykey(ent.var_4bdc8a1a86868e9); isDefined(firstkey) && !isent(ent.var_4bdc8a1a86868e9[firstkey]); firstkey = getfirstarraykey(ent.var_4bdc8a1a86868e9)) {
    ent.var_4bdc8a1a86868e9[firstkey] = undefined;
  }

  if(ent.var_4bdc8a1a86868e9[firstkey] == self) {
    if(isPlayer(ent)) {
      player = ent;

      if(player.var_1e8e6d27dc0e62a2 != minimap_floor) {
        player[[setfunc]](minimap_floor, var_5269d98756c2f039);
        player.var_1e8e6d27dc0e62a2 = minimap_floor;
      }
    } else if(ent vehicle::is_vehicle() && isDefined(ent.owners)) {
      foreach(player in ent.owners) {
        if(isPlayer(player) && player.var_1e8e6d27dc0e62a2 != minimap_floor) {
          player[[setfunc]](minimap_floor, var_5269d98756c2f039);
          player.var_1e8e6d27dc0e62a2 = minimap_floor;
        }
      }
    }
  }

  wait level.framedurationseconds * 2;
  ent.var_4bdc8a1a86868e9[triggernum] = undefined;
}