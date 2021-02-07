package message;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class TestMessage {

    @Test
    public void testNameStudent() {

        Message obj = new Message();
        assertEquals("Hello student", obj.getMessage("student"));
    }

    @Test
    public void testNameEmpty() {

        MessageBuilder obj = new MessageBuilder();
        assertEquals("Please provide a name!", obj.getMessage(" "));

    }
}

