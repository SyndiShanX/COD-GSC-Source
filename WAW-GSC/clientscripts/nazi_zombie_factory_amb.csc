/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\nazi_zombie_factory_amb.csc
*****************************************************/

#include clientscripts\_utility;
#include clientscripts\_ambientpackage;
#include clientscripts\_music;

main() {
    /
    homepad_loop() {
      level waittill("pap1");
      homepad = getstruct("homepad_power_looper", "targetname");
      home_breaker = getstruct("homepad_breaker", "targetname");
      if(isDefined(homepad)) {
        clientscripts\_audio::playloopat(0, "homepad_power_loop", homepad.origin, 1);
      }
      if(isDefined(home_breaker)) {
        clientscripts\_audio::playloopat(0, "break_arc", home_breaker.origin, 1);
      }
    }
    teleport_pad_init(pad) {
      telepad = getstructarray("telepad_" + pad, "targetname");
      telepad_loop = getstructarray("telepad_" + pad + "_looper", "targetname");
      homepad = getstructarray("homepad", "targetname");
      level waittill("tp" + pad);
      array_thread(telepad_loop, ::telepad_loop);
      array_thread(telepad, ::teleportation_audio, pad);
      array_thread(homepad, ::teleportation_audio, pad);
    }
    telepad_loop() {
      clientscripts\_audio::playloopat(0, "power_loop", self.origin, 1);
    }
    teleportation_audio(pad) {
      teleport_delay = 2;
      while(1) {
        level waittill("tpw" + pad);
        if(isDefined(self.script_sound)) {
          if(self.targetname == "telepad_" + pad) {
            playSound(0, self.script_sound + "_warmup", self.origin);
            realwait(teleport_delay);
            playSound(0, self.script_sound + "_cooldown", self.origin);
          }
          if(self.targetname == "homepad") {
            realwait(teleport_delay);
            playSound(0, self.script_sound + "_warmup", self.origin);
            playSound(0, self.script_sound + "_cooldown", self.origin);
          }
        }
      }
    }
    /
    pole_fx_audio_init(pad) {
      pole = getstructarray("pole_fx_" + pad, "targetname");
      array_thread(pole, ::pole_fx_audio, pad);
    }
    pole_fx_audio(pad) {
      level waittill("scd" + pad);
      while(1) {
        playFX(0, level._effect["zombie_elec_pole_terminal"], self.origin, anglesToForward(self.angles));
        playSound(0, "pole_spark", self.origin);
        realwait(randomintrange(2, 7));
      }
    }
    pa_level_start() {
      wait(2);
      playSound(0, "pa_buzz", self.origin);
      wait(1.2);
      self pa_play_dialog("pa_level_start");
    }
    pa_power_on() {
      level waittill("pl1");
      playSound(0, "pa_buzz", self.origin);
      wait(1.2);
      self pa_play_dialog("pa_power_on");
    }