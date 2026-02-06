function [nextObs, reward, isDone, log] = stepFunction(action, log)

    log.idx = log.idx + 1;

    if log.idx > log.maxSteps
        nextObs = log.state;
        reward = 0;
        isDone = true;
        return;
    end

    row = log.data(log.idx, :);

    hysteresis = row.HO_Hysteresis_dB + action;
    hysteresis = max(min(hysteresis,10),0);

    rsrp_s  = row.Serving_RSRP_dBm;
    rsrp_n  = row.Neighbor_RSRP_dBm;
    sinr    = row.Serving_SINR_dB;
    load    = row.Serving_Cell_Load_pct;
    thrpt   = row.Throughput_Mbps;
    latency = row.Latency_ms;

    outcome = row.HO_Success;

    reward = 0;

    if outcome == 1
        reward = reward + 10;
    else
        reward = reward - 10;
    end

    reward = reward + thrpt/10;
    reward = reward - latency/50;
    reward = reward - load/10;

    nextObs = [rsrp_s; rsrp_n; sinr; load; row.UE_Speed_kmph];

    isDone = false;
    log.state = nextObs;
    log.hysteresis = hysteresis;

end
