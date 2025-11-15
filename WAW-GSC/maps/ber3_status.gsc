/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\ber3_status.gsc
*****************************************************/

build_status() {
  intro();
  atgun();
  wave();
  foyer();
  parliament();
  roof();
}

intro() {
  maps\_status::scripter_task("intro", 5, 0);
  maps\_status::scripter_subtask("Objectives", 1, 100);
  maps\_status::scripter_subtask("Gameplay", 1, 100);
  maps\_status::scripter_subtask("IGC Camera", 1, 100);
  maps\_status::scripter_subtask("Animation", 1, 0, "Waiting on assets");
  maps\_status::scripter_subtask("FX", 1, 0, "N/A");
}

atgun() {
  maps\_status::scripter_task("atgun", 5, 0);
  maps\_status::scripter_subtask("Objectives", 1, 100);
  maps\_status::scripter_subtask("Gameplay", 1, 100, "PTRS turrets are haxed b/c of projectile turret and damage trigger bugs");
  maps\_status::scripter_subtask("Animation", 1, 0, "coming soon");
  maps\_status::scripter_subtask("FX", 1, 0, "N/A");
}

wave() {
  maps\_status::scripter_task("wave", 5, 0);
  maps\_status::scripter_subtask("Objectives", 1, 100);
  maps\_status::scripter_subtask("Gameplay", 1, 100);
  maps\_status::scripter_subtask("IGC Camera", 1, 100);
  maps\_status::scripter_subtask("Animation", 1, 0, "coming soon");
  maps\_status::scripter_subtask("FX", 1, 0, "N/A");
}

foyer() {
  maps\_status::scripter_task("foyer", 5, 0);
  maps\_status::scripter_subtask("Objectives", 1, 100);
  maps\_status::scripter_subtask("Gameplay", 1, 100);
  maps\_status::scripter_subtask("Animation", 1, 0, "coming soon");
  maps\_status::scripter_subtask("FX", 1, 100);
}

parliament() {
  maps\_status::scripter_task("parliament", 5, 0);
  maps\_status::scripter_subtask("Objectives", 1, 100);
  maps\_status::scripter_subtask("Gameplay", 1, 100);
  maps\_status::scripter_subtask("Animation", 1, 0, "coming soon");
  maps\_status::scripter_subtask("FX", 1, 0, "N/A");
}

roof() {
  maps\_status::scripter_task("roof", 5, 0);
  maps\_status::scripter_subtask("Objectives", 1, 100);
  maps\_status::scripter_subtask("Gameplay", 1, 100);
  maps\_status::scripter_subtask("IGC Camera", 1, 100);
  maps\_status::scripter_subtask("Animation", 1, 0, "coming soon");
  maps\_status::scripter_subtask("FX", 1, 0, "waiting on ashes from Barry");
}