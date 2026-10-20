package com.example.demo.modle;

import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.annotation.Id;
import java.time.Instant;

@Document(collation = "messages")
@Data
@NoArgsConstructor
public class Message {
    @Id
    private String Id;
    private String ChatId;
    private String SenderId;
    private Instant CreateAd = Instant.now();
    private MessageType type;
    private enum MessageType{
        GIF,TEXT
    }
    private Boolean IsEdited;

}
