/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_equalizer.gsc
*****************************************************/

#include maps\_utility;

loadPresets() {
    /
    define_filter(name) {
      assertex(!isDefined(level.eq_defs[name]), "Filter " + name + " is already defined");
      level.eq_defs[name] = [];
    }
    set_filter_type(name, band, type) {
      assertex(isDefined(level.eq_defs[name]), "Filter " + name + " is not defined");
      assert(band >= 0 && band < 3);
      level.eq_defs[name]["type"][band] = type;
    }
    set_filter_freq(name, band, freq) {
      assertex(isDefined(level.eq_defs[name]), "Filter " + name + " is not defined");
      assert(band >= 0 && band < 3);
      level.eq_defs[name]["freq"][band] = freq;
    }
    set_filter_gain(name, band, gain) {
      assertex(isDefined(level.eq_defs[name]), "Filter " + name + " is not defined");
      assert(band >= 0 && band < 3);
      level.eq_defs[name]["gain"][band] = gain;
    }
    set_filter_q(name, band, q) {
      assertex(isDefined(level.eq_defs[name]), "Filter " + name + " is not defined");
      assert(band >= 0 && band < 3);
      level.eq_defs[name]["q"][band] = q;
    }
    define_reverb(name) {
      assertex(!isDefined(level.ambient_reverb[name]), "Reverb " + name + " is already defined");
      level.ambient_reverb[name] = [];
    }
    set_reverb_roomtype(name, roomtype) {
      assertex(isDefined(level.ambient_reverb[name]), "Reverb " + name + " is not defined");
      level.ambient_reverb[name]["roomtype"] = roomtype;
    }
    set_reverb_drylevel(name, drylevel) {
      assertex(isDefined(level.ambient_reverb[name]), "Reverb " + name + " is not defined");
      level.ambient_reverb[name]["drylevel"] = drylevel;
    }
    set_reverb_wetlevel(name, wetlevel) {
      assertex(isDefined(level.ambient_reverb[name]), "Reverb " + name + " is not defined");
      level.ambient_reverb[name]["wetlevel"] = wetlevel;
    }
    set_reverb_fadetime(name, fadetime) {
      assertex(isDefined(level.ambient_reverb[name]), "Reverb " + name + " is not defined");
      level.ambient_reverb[name]["fadetime"] = fadetime;
    }
    set_reverb_priority(name, priority) {
      assertex(isDefined(level.ambient_reverb[name]), "Reverb " + name + " is not defined");
      level.ambient_reverb[name]["priority"] = priority;
    }
    getFilter(name) {
      if(isDefined(name) && isDefined(level.eq_defs) && isDefined(level.eq_defs[name]))
        return level.eq_defs[name];
      else
        return undefined;
    }
    add_channel_to_filter(track, channel) {
      if(!isDefined(level.ambient_eq[track]))
        level.ambient_eq[track] = [];
      level.ambient_eq[track][channel] = track;
    }