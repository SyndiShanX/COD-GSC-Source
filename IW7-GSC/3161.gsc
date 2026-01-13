/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3161.gsc
*********************************************/

func_2371() {
  if(scripts\asm\asm::func_232E("shoot_c12_left")) {
    return;
  }

  scripts\asm\asm::func_230B("shoot_c12_left", "shoot_init");
  scripts\asm\asm::func_2374("shoot_rocket", ::lib_0C41::func_35D6, undefined, undefined, ::lib_0C41::func_3613, undefined, ::lib_0C41::func_3526, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("shoot_rocket_idle", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("shoot_rocket_idle", undefined, ::lib_0C42::func_3517, undefined);
  scripts\asm\asm::func_2374("shoot_minigun", ::lib_0C41::func_35D5, undefined, undefined, ::lib_0C41::func_3612, undefined, ::lib_0C41::func_3525, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("shoot_minigun_idle", undefined, ::lib_0C42::func_3519, "minigun");
  scripts\asm\asm::func_2375("shoot_minigun_idle", undefined, ::lib_0C42::func_3517, undefined);
  scripts\asm\asm::func_2374("shoot_minigun_idle", ::lib_0C41::func_35D4, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("shoot_minigun", undefined, ::lib_0C42::func_351A, "minigun");
  scripts\asm\asm::func_2374("shoot_init", ::lib_0C42::func_35E3, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("shoot_rocket_idle", undefined, ::lib_0C42::func_3514, "rocket");
  scripts\asm\asm::func_2375("shoot_minigun_idle", undefined, ::lib_0C42::func_3514, "minigun");
  scripts\asm\asm::func_2374("shoot_rocket_idle", ::lib_0C41::func_35D4, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("shoot_rocket", undefined, ::lib_0C42::func_351A, "rocket");
  scripts\asm\asm::func_2327();
}