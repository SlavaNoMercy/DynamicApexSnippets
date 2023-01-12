public with sharing class TypeNotDefinedException extends Exception {
    public TypeNotDefinedException(Object typeName) {
        this.setMessage('Following type is not defined: ' + String.valueOf(typeName));
    }
}