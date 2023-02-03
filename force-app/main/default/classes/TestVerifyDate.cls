@isTest
private class TestVerifyDate {
    @isTest static void testWarmTemp() {
        date CheckDates = VerifyDate.CheckDates(Date.today(),Date.today());
    }
    @isTest static void testWarmTemp2() {
        date CheckDates = VerifyDate.CheckDates(Date.today(),Date.today().addMonths(1));
    }
}