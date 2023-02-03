trigger product2Trigger on Product2 (after update) {
    Product2Helper.AfterUpdate(Trigger.new, Trigger.old);

}