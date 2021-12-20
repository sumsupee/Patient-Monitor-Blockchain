pragma solidity ^0.4.0;

contract BloodPressureMonitor {
    function analyze(
        uint256 bp,
        uint256 min,
        uint256 max
    ) public constant returns (uint256) {
        uint256 x = 5;
        if (bp < min || bp > max) {
            if (bp < min - 20 || bp > max + 20) {
                x = 2;
                return (x);
            }
            x = 1;
            return (x);
        } else {
            x = 0;
            return (x);
        }
    }
}

contract Device {
    uint256 x = 5;

    function analyze(
        uint256 reading,
        uint256 min,
        uint256 max
    ) public {
        if (reading < min || reading > max) {
            if (reading < min - 20 || reading > max + 20) {
                x = 2;
                // return (x);
            } else x = 1;
            // return (x);
        } else {
            x = 0;
            // return (x);
        }
    }

    function retrieve() public view returns (uint256) {
        return x;
    }
}

contract HeartRateMonitor {
    function analyze(
        uint256 bpm,
        uint256 min,
        uint256 max
    ) public constant returns (uint256) {
        uint256 x = 5;
        if (bpm < min || bpm > max) {
            if (bpm < min - 20 || bpm > max + 20) {
                x = 2;
                return (x);
            }
            x = 1;
            return (x);
        } else {
            x = 0;
            return (x);
        }
    }
}

contract GlucoseMonitor {
    function analyze(
        uint256 glucoseLevel,
        uint256 low,
        uint256 high
    ) public constant returns (uint256) {
        uint256 x = 5;
        if (glucoseLevel < low || glucoseLevel > high) {
            if (glucoseLevel < low - 20 || glucoseLevel > high + 80) {
                if (glucoseLevel > high + 140) {
                    x = 3;
                    return (x);
                }
                x = 2;
                return (x);
            }
            x = 1;
            return (x);
        } else {
            x = 0;
            return (x);
        }
    }
}

contract HealthContractCaller {
    Device[] public patients;

    function createPatientDevice() public {
        Device patient = new Device();
        patients.push(patient);
    }

    function recordAnalyze(
        uint256 _patientDeviceIndex,
        uint256 _patientDeviceReading,
        uint256 low,
        uint256 high
    ) public {
        // Address
        // ABI
        Device(address(patients[_patientDeviceIndex])).analyze(
            _patientDeviceReading,
            low,
            high
        );
    }

    function deviceRead(uint256 _patientDeviceIndex)
        public
        view
        returns (uint256)
    {
        return Device(address(patients[_patientDeviceIndex])).retrieve();
    }

    function bloodPressureMonitor(
        uint256 bp,
        uint256 low,
        uint256 high
    ) public constant returns (uint256 code) {
        BloodPressureMonitor bpl = new BloodPressureMonitor();

        return bpl.analyze(bp, low, high);
    }

    function heartRateMonitor(
        uint256 bpm,
        uint256 min,
        uint256 max
    ) public constant returns (uint256 code) {
        HeartRateMonitor hrm = new HeartRateMonitor();

        return hrm.analyze(bpm, min, max);
    }

    function glucoseMonitor(
        uint256 glucoseLevel,
        uint256 low,
        uint256 high
    ) public constant returns (uint256 code) {
        GlucoseMonitor gm = new GlucoseMonitor();

        return gm.analyze(glucoseLevel, low, high);
    }
}
