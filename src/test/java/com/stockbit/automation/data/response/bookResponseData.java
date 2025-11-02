package com.stockbit.automation.data.response;

import lombok.Data;

@Data
public class bookResponseData {
    Integer id;
    String title;
    String author;
    String genre;
    String description;
    String isbn;
    String image;
    String published;
}
