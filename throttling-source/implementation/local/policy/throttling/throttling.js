// Copyright IBM Corp. 2017. All Rights Reserved.
// Licensed under "The MIT License (MIT)"
var apic = require('local:isp/policy/apim.custom.js');
var rl = require('ratelimit');

var props = apic.getPolicyProperty();
var name = props.key;
var number = props.token;
var interval = props.interval;
var intervalType = props.intervalType;

var rate = rl.rateCreate(name, number, interval, intervalType);
loop();

function loop() {

    rate.remove(1, function(err, remaining, timeToReset) {

        var out = {
            remaining: remaining,
            timeToReset: timeToReset
        }

        console.log(out);
        if (err) {
            console.log(err);
            apic.error("'" + name + "' RateLimit", 429, "Maximum through put has been hit,  message rejected!")
        } else {
            apic.readInputAsBuffer(function(readError, buf) {
                session.output.write(buf);
            });
        }
    });
}
