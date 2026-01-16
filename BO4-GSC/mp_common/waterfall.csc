/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\waterfall.csc
***********************************************/

#include scripts\core_common\filter_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\trigger_shared;
#include scripts\core_common\water_surface;

#namespace waterfall;

waterfalloverlay(localclientnum) {
  triggers = getEntArray(localclientnum, "waterfall", "targetname");

  foreach(trigger in triggers) {
    trigger thread setupwaterfall(localclientnum);
  }
}

waterfallmistoverlay(localclientnum) {
  triggers = getEntArray(localclientnum, "waterfall_mist", "targetname");

  foreach(trigger in triggers) {
    trigger thread setupwaterfallmist(localclientnum);
  }
}

waterfallmistoverlayreset(localclientnum) {
  localplayer = function_5c10bd79(localclientnum);
  localplayer.rainopacity = 0;
}

setupwaterfallmist(localclientnum) {
  level notify("setupWaterfallmist_waterfall_csc" + localclientnum);
  level endon("setupWaterfallmist_waterfall_csc" + localclientnum);
  trigger = self;

  for(;;) {
    waitresult = trigger waittill(#"trigger");
    trigplayer = waitresult.activator;

    if(!trigplayer function_21c0fa55()) {
      continue;
    }

    localclientnum = trigplayer getlocalclientnumber();

    if(isDefined(localclientnum)) {
      localplayer = function_5c10bd79(localclientnum);
    } else {
      localplayer = trigplayer;
    }

    filter::init_filter_sprite_rain(localplayer);
    trigger thread trigger::function_thread(localplayer, &trig_enter_waterfall_mist, &trig_leave_waterfall_mist);
  }
}

setupwaterfall(localclientnum, localowner) {
  level notify(#"setupwaterfall_waterfall_csc" + string(localclientnum));
  level endon(#"setupwaterfall_waterfall_csc" + string(localclientnum));
  trigger = self;

  for(;;) {
    waitresult = trigger waittill(#"trigger");
    trigplayer = waitresult.activator;

    if(!trigplayer function_21c0fa55()) {
      continue;
    }

    localclientnum = trigplayer getlocalclientnumber();

    if(isDefined(localclientnum)) {
      localplayer = function_5c10bd79(localclientnum);
    } else {
      localplayer = trigplayer;
    }

    trigger thread trigger::function_thread(localplayer, &trig_enter_waterfall, &trig_leave_waterfall);
  }
}

trig_enter_waterfall(localplayer) {
  trigger = self;
  localclientnum = localplayer.localclientnum;
  localplayer thread postfx::playpostfxbundle(#"pstfx_waterfall");
  playSound(0, #"amb_waterfall_hit", (0, 0, 0));

  while(trigger istouching(localplayer)) {
    localplayer playrumbleonentity(localclientnum, "waterfall_rumble");
    wait 0.1;
  }
}

trig_leave_waterfall(localplayer) {
  trigger = self;
  localclientnum = localplayer.localclientnum;
  localplayer postfx::stoppostfxbundle("pstfx_waterfall");

  if(isunderwater(localclientnum) == 0) {
    localplayer thread water_surface::startwatersheeting();
  }
}

trig_enter_waterfall_mist(localplayer) {
  localplayer endon(#"death");
  trigger = self;

  if(!isDefined(localplayer.rainopacity)) {
    localplayer.rainopacity = 0;
  }

  if(localplayer.rainopacity == 0) {
    filter::set_filter_sprite_rain_seed_offset(localplayer, 0, randomfloat(1));
  }

  filter::enable_filter_sprite_rain(localplayer, 0);

  while(trigger istouching(localplayer)) {
    localclientnum = trigger.localclientnum;

    if(!isDefined(localclientnum)) {
      localclientnum = localplayer getlocalclientnumber();
    }

    if(isunderwater(localclientnum)) {
      filter::disable_filter_sprite_rain(localplayer, 0);
      break;
    }

    localplayer.rainopacity += 0.003;

    if(localplayer.rainopacity > 1) {
      localplayer.rainopacity = 1;
    }

    filter::set_filter_sprite_rain_opacity(localplayer, 0, localplayer.rainopacity);
    filter::set_filter_sprite_rain_elapsed(localplayer, 0, localplayer getclienttime());
    waitframe(1);
  }
}

trig_leave_waterfall_mist(localplayer) {
  localplayer endon(#"death");
  trigger = self;

  if(isDefined(localplayer.rainopacity)) {
    while(!trigger istouching(localplayer) && localplayer.rainopacity > 0) {
      localclientnum = trigger.localclientnum;

      if(isunderwater(localclientnum)) {
        filter::disable_filter_sprite_rain(localplayer, 0);
        break;
      }

      localplayer.rainopacity -= 0.005;
      filter::set_filter_sprite_rain_opacity(localplayer, 0, localplayer.rainopacity);
      filter::set_filter_sprite_rain_elapsed(localplayer, 0, localplayer getclienttime());
      waitframe(1);
    }
  }

  localplayer.rainopacity = 0;
  filter::disable_filter_sprite_rain(localplayer, 0);
}