function [initialObs, log] = resetFunction(data)

    log.data = data;
    log.idx = 1;
    log.maxSteps = height(data);

    initialObs = [
        data.Serving_RSRP_dBm(1);
        data.Neighbor_RSRP_dBm(1);
        data.Serving_SINR_dB(1);
        data.Serving_Cell_Load_pct(1);
        data.UE_Speed_kmph(1)
    ];

    log.hysteresis = data.HO_Hysteresis_dB(1);
    log.state = initialObs;

end
