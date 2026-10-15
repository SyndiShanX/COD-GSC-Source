/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\tacticalinsertion.csc
***********************************************/

#include scripts\core_common\audio_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\fx_shared;
#include scripts\core_common\struct;

#namespace tacticalinsertion;

init_shared() {
  level._effect[#"tacticalinsertionfriendly"] = #"_t6/misc/fx_equip_tac_insert_light_grn";
  level._effect[#"tacticalinsertionenemy"] = #"_t6/misc/fx_equip_tac_insert_light_red";
  clientfield::register("scriptmover", "tacticalinsertion", 1, 1, "int", &spawned, 0, 0);
  latlongstruct = struct::get("lat_long", "targetname");

  if(isDefined(latlongstruct)) {
    mapx = latlongstruct.origin[0];
    mapy = latlongstruct.origin[1];
    lat = latlongstruct.script_vector[0];
    long = latlongstruct.script_vector[1];
  } else {
    if(isDefined(level.worldmapx) && isDefined(level.worldmapy)) {
      mapx = level.worldmapx;
      mapy = level.worldmapy;
    } else {
      mapx = 0;
      mapy = 0;
    }

    if(isDefined(level.worldlat) && isDefined(level.worldlong)) {
      lat = level.worldlat;
      long = level.worldlong;
    } else {
      lat = 34.0216;
      long = -118.449;
    }
  }

  setmaplatlong(mapx, mapy, long, lat);
}

spawned(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!newval) {
    return;
  }

  self thread playflarefx(localclientnum);
  self thread checkforplayerswitch(localclientnum);
}

playflarefx(localclientnum) {
  self endon(#"death");
  level endon(#"player_switch");
  self.tacticalinsertionfx = self fx::function_3539a829(localclientnum, level._effect[#"tacticalinsertionfriendly"], level._effect[#"tacticalinsertionenemy"], "tag_flash");
  self thread watchtacinsertshutdown(localclientnum, self.tacticalinsertionfx);
  looporigin = self.origin;
  audio::playloopat("fly_tinsert_beep", looporigin);
  self thread stopflareloopwatcher(looporigin);
}

watchtacinsertshutdown(localclientnum, fxhandle) {
  self waittill(#"death");

  if(isDefined(fxhandle)) {
    stopfx(localclientnum, fxhandle);
  }
}

stopflareloopwatcher(looporigin) {
  while(true) {
    if(!isDefined(self) || !isDefined(self.tacticalinsertionfx)) {
      audio::stoploopat("fly_tinsert_beep", looporigin);
      break;
    }

    wait 0.5;
  }
}

checkforplayerswitch(localclientnum) {
  self endon(#"death");

  while(true) {
    level waittill(#"player_switch");

    if(isDefined(self.tacticalinsertionfx)) {
      stopfx(localclientnum, self.tacticalinsertionfx);
      self.tacticalinsertionfx = undefined;
    }

    waittillframeend();
    self thread playflarefx(localclientnum);
  }
}