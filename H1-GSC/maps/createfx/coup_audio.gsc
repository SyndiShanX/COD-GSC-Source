/****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createfx\coup_audio.gsc
****************************************/

main() {
  thread init_animsounds();
}

init_animsounds() {
  waittillframeend;
  maps\_anim::addnotetrack_animsound("playerview", "intro", "throw_in_car", "scn_coup_throw_in_car");
  maps\_anim::addnotetrack_animsound("playerview", "intro", "hit", "scn_coup_rifle_butt");
  maps\_anim::addnotetrack_animsound("human", "intro_leftguard", "closing_door", "scn_coup_car_door_close");
  maps\_anim::addnotetrack_animsound("human", "intro_leftguard", "roof_tap", "scn_coup_roof_tap");
  maps\_anim::addnotetrack_customfunction("human", "roof_tap", ::setmusic_p2_flag);
  maps\_anim::addnotetrack_animsound("human", "carexit_leftguard", "door_open", "scn_coup_car_door_open");
  maps\_anim::addnotetrack_animsound("playerview", "carexit", "pulled_from_car", "scn_coup_pulled_from_car");
  maps\_anim::addnotetrack_animsound("playerview", "carexit", "kick", "scn_coup_curb_stomp");
  maps\_anim::addnotetrack_customfunction("playerview", "kick", ::curb_stomp_mix, "carexit");
  maps\_anim::addnotetrack_animsound("playerview", "ending", "tied_to_post", "scn_coup_tied_to_post");
  maps\_anim::addnotetrack_animsound("human", "ending_alasad", "cock_gun", "assassination_hammer");
  maps\_anim::addnotetrack_animsound("dumpster", "dumpster_open", "lid_close", "scn_dumpster_lid_close");
  maps\_anim::addnotetrack_animsound("trashcan_rig", "trash_stumble", "sound_trashcan", "scn_trashcan_knock_over");
}

setmusic_p2_flag(var_0) {
  common_scripts\utility::flag_set("music_part2");
}

curb_stomp_mix(var_0) {
  thread maps\coup_aud::aud_curb_stomp_event();
}