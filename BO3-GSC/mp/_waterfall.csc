/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_waterfall.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_load;
#using scripts\mp\_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\filter_shared;
#using scripts\shared\postfx_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using scripts\shared\water_surface;
#namespace waterfall;

function waterfalloverlay(localclientnum) {
  triggers = getentarray(localclientnum, "waterfall", "targetname");
  foreach(trigger in triggers) {
    trigger thread setupwaterfall(localclientnum);
  }
}

function waterfallmistoverlay(localclientnum) {
  triggers = getentarray(localclientnum, "waterfall_mist", "targetname");
  foreach(trigger in triggers) {
    trigger thread setupwaterfallmist(localclientnum);
  }
}

function waterfallmistoverlayreset(localclientnum) {
  localplayer = getlocalplayer(localclientnum);
  localplayer.rainopacity = 0;
}

function setupwaterfallmist(localclientnum) {
  level notify("setupWaterfallmist_waterfall_csc" + localclientnum);
  level endon("setupWaterfallmist_waterfall_csc" + localclientnum);
  trigger = self;
  for (;;) {
    trigger waittill("trigger", trigplayer);
    if(!trigplayer islocalplayer()) {
      continue;
    }
    localclientnum = trigplayer getlocalclientnumber();
    if(isdefined(localclientnum)) {
      localplayer = getlocalplayer(localclientnum);
    } else {
      localplayer = trigplayer;
    }
    filter::init_filter_sprite_rain(localplayer);
    trigger thread trigger::function_d1278be0(localplayer, & trig_enter_waterfall_mist, & trig_leave_waterfall_mist);
  }
}

function setupwaterfall(localclientnum, localowner) {
  level notify("setupWaterfall_waterfall_csc" + localclientnum);
  level endon("setupWaterfall_waterfall_csc" + localclientnum);
  trigger = self;
  for (;;) {
    trigger waittill("trigger", trigplayer);
    if(!trigplayer islocalplayer()) {
      continue;
    }
    localclientnum = trigplayer getlocalclientnumber();
    if(isdefined(localclientnum)) {
      localplayer = getlocalplayer(localclientnum);
    } else {
      localplayer = trigplayer;
    }
    trigger thread trigger::function_d1278be0(localplayer, & trig_enter_waterfall, & trig_leave_waterfall);
  }
}

function trig_enter_waterfall(localplayer) {
  trigger = self;
  localclientnum = localplayer.localclientnum;
  localplayer thread postfx::playpostfxbundle("pstfx_waterfall");
  playsound(0, "amb_waterfall_hit", (0, 0, 0));
  while (trigger istouching(localplayer)) {
    localplayer playrumbleonentity(localclientnum, "waterfall_rumble");
    wait(0.1);
  }
}

function trig_leave_waterfall(localplayer) {
  trigger = self;
  localclientnum = localplayer.localclientnum;
  localplayer postfx::stoppostfxbundle();
  if(isunderwater(localclientnum) == 0) {
    localplayer thread water_surface::startwatersheeting();
  }
}

function trig_enter_waterfall_mist(localplayer) {
  localplayer endon("entityshutdown");
  trigger = self;
  if(!isdefined(localplayer.rainopacity)) {
    localplayer.rainopacity = 0;
  }
  if(localplayer.rainopacity == 0) {
    filter::set_filter_sprite_rain_seed_offset(localplayer, 0, randomfloat(1));
  }
  filter::enable_filter_sprite_rain(localplayer, 0);
  while (trigger istouching(localplayer)) {
    localclientnum = trigger.localclientnum;
    if(!isdefined(localclientnum)) {
      localclientnum = localplayer getlocalclientnumber();
    }
    if(isunderwater(localclientnum)) {
      filter::disable_filter_sprite_rain(localplayer, 0);
      break;
    }
    localplayer.rainopacity = localplayer.rainopacity + 0.003;
    if(localplayer.rainopacity > 1) {
      localplayer.rainopacity = 1;
    }
    filter::set_filter_sprite_rain_opacity(localplayer, 0, localplayer.rainopacity);
    filter::set_filter_sprite_rain_elapsed(localplayer, 0, localplayer getclienttime());
    wait(0.016);
  }
}

function trig_leave_waterfall_mist(localplayer) {
  localplayer endon("entityshutdown");
  trigger = self;
  if(isdefined(localplayer.rainopacity)) {
    while (!trigger istouching(localplayer) && localplayer.rainopacity > 0) {
      localclientnum = trigger.localclientnum;
      if(isunderwater(localclientnum)) {
        filter::disable_filter_sprite_rain(localplayer, 0);
        break;
      }
      localplayer.rainopacity = localplayer.rainopacity - 0.005;
      filter::set_filter_sprite_rain_opacity(localplayer, 0, localplayer.rainopacity);
      filter::set_filter_sprite_rain_elapsed(localplayer, 0, localplayer getclienttime());
      wait(0.016);
    }
  }
  localplayer.rainopacity = 0;
  filter::disable_filter_sprite_rain(localplayer, 0);
}