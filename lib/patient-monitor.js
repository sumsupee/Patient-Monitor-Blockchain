/*
 * SPDX-License-Identifier: Apache-2.0
 */

'use strict';

const { Contract } = require('fabric-contract-api');

class PatientMonitor extends Contract {

    async myPatientExists(ctx, myPatientId) {
        const buffer = await ctx.stub.getState(myPatientId);
        return (!!buffer && buffer.length > 0);
    }


    async createMyPatient(ctx, myPatientId) {
        const exists = await this.myPatientExists(ctx, myPatientId);
        if (exists) {
            throw new Error(`The patient ${myPatientId} already exists`);
        }
        var value = 0;
        const patient = { value };
        const buffer = Buffer.from(JSON.stringify(patient));
        await ctx.stub.putState(myPatientId, buffer);
    }

    async readMyPatient(ctx, myPatientId) {
        const exists = await this.myPatientExists(ctx, myPatientId);
        if (!exists) {
            throw new Error(`The patient ${myPatientId} does not exist`);
        }
        const buffer = await ctx.stub.getState(myPatientId);
        const patient = JSON.parse(buffer.toString());
        return patient;
    }

    async updateMyPatient(ctx, myPatientId, bp, min, max) {
        const exists = await this.myPatientExists(ctx, myPatientId);
        if (!exists) {
            throw new Error(`The patient ${myPatientId} does not exist`);
        }
        bp = parseInt(bp);
        min = parseInt(min);
        max = parseInt(max);

        var x = 0;
        if (bp < min || bp > max) {
            if (bp < (min - 20) || bp > (max + 20)) {
                x = 2;
            }
            else {
                x = 1;
            }
        }
        else {
            //x = 0;
            return 'Normal';
        }
        if (x == 2 || x == 1) {
            const patient = { value: x };
            const buffer = Buffer.from(JSON.stringify(patient));
            await ctx.stub.putState(myPatientId, buffer);
            if (x == 2) {
                const eventPayload = Buffer.from(`ALERT!! ${myPatientId} has reached maximum alert level. Proceed for hospitalsiation.`);
                ctx.stub.setEvent('myEvent', eventPayload);
            }
        }

    }

    async deleteMyPatient(ctx, myPatientId) {
        const exists = await this.myPatientExists(ctx, myPatientId);
        if (!exists) {
            throw new Error(`The patient ${myPatientId} does not exist`);
        }
        await ctx.stub.deleteState(myPatientId);
    }
}

module.exports = PatientMonitor;