# Patient Monitoring using Blockchain

This repository is an extension to the paper: Healthcare Blockchain System Using Smart Contracts for Secure Automated Remote Patient Monitoring, by Kristen N. Griggs et al, [https://doi.org/10.1007/s10916-018-0982-x](https://doi.org/10.1007/s10916-018-0982-x)

We have extended the implementation of the solution presented in this paper on the Hyperledger Fabric while making subtle improvements to the storage of the states on the ledger.

We have also attached a fully functional Solidity Contract which is a modular extension of the one presented in the paper.

## Hyperledger Fabric Implementation

SmartContract Language: Javascript(node.js)

Health Status levels used(can be modified according to the sensor used)
0 - Initialization/Normal
1 - Danger
2 - Highly Dangerous
*Normal levels are not stored.

PatientMonitor Smart Contract contains 5 methods :-

1. **createMyPatient(ctx,myPatientId)** - Used to initialize patient related information for new patients.
2. **readMyPatient(ctx,myPatientId)** - Used to read the current health status of a patient.
3. **updateMyPatient(ctx,myPatientId,bp,min,max)** - Update the health status of patient according to the input parameters and emit&#39;s event triggers when in a highly dangerous level(here 2)
4. **deleteMyPatient(ctx,myPatientId)** - Used to delete patient related information.
5. **myPatientExists(ctx,myPatientId)** - Used to find whether a particular patient exists or not.

Hyperledger Fabric Implementation using IBM Blockchain VS Code Extension.

- Package the Smart Contract
- Deploy Smart Contract

## Solidity Implementation

PatientMonitor.sol contract contains the following in addition to the implementation provided in the paper by Kohlios, C.P., [https://github.com/ckohlios/Healthcare\_IoT\_Blockchain](https://github.com/ckohlios/Healthcare_IoT_Blockchain) -

1. **Device** contract - Contract definition for any additional device to be connected to the network
2. **createPatientDevice()** - Used to create a new Device contract for any new patient/device
3. **recordAnalyze( \_patientDeviceIndex, \_patientDeviceReading,low,high)** - Used to analyse the readings of any Device/patient and then classify them in any of the danger categories
4. **deviceRead(\_patientDeviceIndex)** - Used to return the stored value for the specific Device contract
