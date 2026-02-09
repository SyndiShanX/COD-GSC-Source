init() {
  setDvar("r_smodelinstancedthreshold", 2);
  setDvar("r_primaryLightUseTweaks", 0);
  setDvar("r_primaryLightTweakDiffuseStrength", 0);
  setDvar("r_primaryLightTweakSpecularStrength", 0);
  setDvar("r_viewModelPrimaryLightUseTweaks", 0);
  setDvar("r_viewModelPrimaryLightTweakDiffuseStrength", 0);
  setDvar("r_viewModelPrimaryLightTweakSpecularStrength", 1);
  setDvar("r_colorScaleUseTweaks", 0);
  setDvar("r_diffuseColorScale", 0);
  setDvar("r_specularColorScale", 0);
  setDvar("r_veil", 0);
  setDvar("r_veilusetweaks", 0);
  setDvar("r_veilStrength", 0.087);
  setDvar("r_veilBackgroundStrength", 0.913);
}

is_iw4_map() {
  map = getDvar("mapname");
  switch (map) {
    case "mp_rust":
    case "mp_afghan":
    case "mp_derail":
    case "mp_estate":
    case "mp_favela":
    case "mp_highrise":
    case "mp_invasion":
    case "mp_checkpoint":
    case "mp_quarry":
    case "mp_rundown":
    case "mp_boneyard":
    case "mp_nightshift":
    case "mp_subbase":
    case "mp_terminal":
    case "mp_underpass":
    case "mp_brecourt":
    case "mp_complex":
    case "mp_compact":
    case "mp_storm":
    case "mp_abandon":
    case "mp_fuel2":
    case "mp_trailerpark":
      return true;
    default:
      return false;
  }
}