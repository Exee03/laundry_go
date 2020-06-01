const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp(functions.config().firebase);

const firestore = admin.firestore();

exports.sentNotification = functions.https.onRequest(async (req, res) => {
    const machineId = req.query.id;
    console.log('Machine id = ' + machineId);
    const ref = admin.database().ref('/' + machineId);
    try {
        console.log('Get userUid in Realtime Database');
        const snapshot = await ref.once('value');
        const data = snapshot.val();
        const userId = data.user;
        await firestore.collection('users').where("uid", "==", userId).get().then((snapshots) => {
            var tokens = [];
            console.log("Check Firestore");
            if (snapshots.empty) {
                console.log('No devices');
                return null;
            } else {
                console.log("Get User");
                for (var user of snapshots.docs) {
                    console.log('Realtime Database : ' + userId);
                    console.log('Firestore         : ' + user.data().uid);

                    if (user.data().uid === userId) {
                        tokens.push(user.data().token);
                        console.log("Get Token");
                    } else {
                        console.log('Uid not available in users collection');
                        return null;
                    }
                    console.log("After get token");
                }
                console.log('Sent notification to user');
                const title = 'Washing is done!';
                const message = 'Please unload your clothes from washing machine no. ' + machineId + '.';
                return sendFCM(tokens, title, message);
            }
        });
        res.send('OK');
    } catch (error) {
        console.log('Error : ' + error);
    }
});

exports.sentErrorNotification = functions.https.onRequest(async (req, res) => {
    const machineId = req.query.id;
    console.log('Machine id = ' + machineId);
    const ref = admin.database().ref('/' + machineId);
    try {
        console.log('Get userUid in Realtime Database');
        const snapshot = await ref.once('value');
        const data = snapshot.val();
        const userId = data.user;
        await firestore.collection('users').where("uid", "==", userId).get().then((snapshots) => {
            var tokens = [];
            console.log("Check Firestore");
            if (snapshots.empty) {
                console.log('No devices');
                return null;
            } else {
                console.log("Get User");
                for (var user of snapshots.docs) {
                    console.log('Realtime Database : ' + userId);
                    console.log('Firestore         : ' + user.data().uid);

                    if (user.data().uid === userId) {
                        tokens.push(user.data().token);
                        console.log("Get Token");
                    } else {
                        console.log('Uid not available in users collection');
                        return null;
                    }
                    console.log("After get token");
                }
                console.log('Sent notification to user');
                const title = 'A problem has occured';
                const message = 'Please check the washing machine.';
                return sendFCM(tokens, title, message);
            }
        });
        res.send('OK');
    } catch (error) {
        console.log('Error : ' + error);
    }
});

async function sendFCM(tokens, title, message) {

    var payload = {
        notification: {
            title: title,
            body: message,
        },
        data: {
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        }
    }
    var options = {
        priority: "high",
        timeToLive: 60 * 60 * 24,
        contentAvailable: true
    };

    return admin.messaging().sendToDevice(tokens, payload, options).then((response) => {
        return console.log('Successfully push notifications : ' + response);
    }).catch((err) => {
        console.log('Error : ' + err);
    })
}