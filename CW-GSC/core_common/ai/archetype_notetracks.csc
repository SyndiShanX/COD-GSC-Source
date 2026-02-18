/***************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_notetracks.csc
***************************************************/

#using scripts\core_common\ai_shared;
#namespace notetracks;

function autoexec main() {
  if(sessionmodeiszombiesgame() && getdvarint(#"splitscreen_playercount", 0) > 2) {
    return;
  }

  ai::add_ai_spawn_function(&initializenotetrackhandlers);
}

function private initializenotetrackhandlers(localclientnum) {
  addsurfacenotetrackfxhandler(localclientnum, "jumping", "surfacefxtable_jumping");
  addsurfacenotetrackfxhandler(localclientnum, "landing", "surfacefxtable_landing");
  addsurfacenotetrackfxhandler(localclientnum, "vtol_landing", "surfacefxtable_vtollanding");
}

function private addsurfacenotetrackfxhandler(localclientnum, notetrack, surfacetable) {
  entity = self;
  entity thread handlesurfacenotetrackfx(localclientnum, notetrack, surfacetable);
}

function private handlesurfacenotetrackfx(localclientnum, notetrack, surfacetable) {
  entity = self;
  entity endon(#"death");

  while(true) {
    entity waittill(notetrack);
    fxname = entity getaifxname(localclientnum, surfacetable);

    if(isDefined(fxname)) {
      playFX(localclientnum, fxname, entity.origin);
    }
  }
}