/*
 * SPDX-License-Identifier: Apache-2.0
 */

'use strict';

const PatientMonitor = require('./lib/patient-monitor');

module.exports.PatientMonitor = PatientMonitor;
module.exports.contracts = [PatientMonitor];