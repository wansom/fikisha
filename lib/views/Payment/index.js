import { https } from 'firebase-functions';
import { initialzeApp } from 'firebase-admin';
initialzeApp();

export const paymentCallBack = https.onRequest(async (req, res) => {
    const callbackData = req.body.Body.stkCallBack;
    console.log('Received payload: ', callbackData);

    const responseCode = callbackData.ResultCode;
    const mCheckoutRequestID = callbackData.CheckoutRequestID;

    if(responseCode == 0) {
        const details = callbackData.CallBackMetadata.Item

        var receipt;
        var phonePaidFrom;
        var amountPaid;

        await details.forEach(entry => {
            switch (entry.Name) {
                case 'MpesaReceiptNumber':
                    receipt = entry.Value
                    break;
                case  'PhoneNumber':
                    phonePaidFrom = entry.Value
                    break;
                case 'Amount':
                    amountPaid = entry.Value  
                    break;              
                default:
                    break;
            }
        })
        const entryDetails ={
            'receipt': receipt,
            'phone': phonePaidFrom,
            'amount': amountPaid
        }

        var matchingCheckoutID = admin.firestore().collectionGroup('deposit')
        .where('CheckoutRequestID', '==', mCheckoutRequestID);

        const queryResults = await matchingCheckoutID.get();

        if(!queryResults.empty) {
            var documentMatchingID = queryResults.docs [0];
            const mail = doc.ref.path.split('/')[1]

            document.ref.update(entryDetails);

            admin.firestore().collection('fikisha_payments')
            .doc(mail).collection('balance')
            .doc('account').get().then(async (account) => {
                
            })
        }
    }
})