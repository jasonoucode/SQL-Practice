# Instagram Clone - Schema

---

|**USERS**   |
|------------|
|id          |
|username    |
|created_at  |

---

|**PHOTOS**  |
|------------|
|id          |
|image_url   |
|user_id     |
|created_at  |

---

|**COMMENTS**  |
|--------------|
|id            |
|comment_text  |
|user_id       |
|photo_id      |
|created_at    |

---

|**LIKES**  |
|-----------|
|user_id    |
|photo_id   |
|created_at |

---

|**FOLLOWS** |
|------------|
|follower_id |
|followee_id |
|created_at  |

---

|**UNFOLLOWS** |
|--------------|
|follower_id   |
|followee_id   |
|created_at    |

---

|**TAGS**    |
|------------|
|id          |
|tag_name    |
|created_at  |

---

|**PHOTO_TAGS** |
|---------------|
|photo_id       |
|tag_id         |


