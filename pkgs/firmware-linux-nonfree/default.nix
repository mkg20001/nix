{ recreatePackage
, firmwareLinuxNonfree
}:

recreatePackage firmwareLinuxNonfree {
  outputHashMode = null;
  outputHashAlgo = null;
  outputHash = null;
  
  postInstall = ''
    rm -rf $out/lib/firmware/netronome         # non-enduser nic vendor
    rm -rf $out/lib/firmware/liquidio          # non-enduser nic vendor
    rm -rf $out/lib/firmware/qcom/sdm845       # mobile hardware
  '';
}
