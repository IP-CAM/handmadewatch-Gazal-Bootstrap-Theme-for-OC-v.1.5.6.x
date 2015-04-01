<form id="login-form" action="">
    <table class="form">
        <tr>
            <td><?php echo $entry_email; ?></td>
            <td><input type="text" name="email" value=""/></td>
        </tr>
        <tr>
            <td><?php echo $entry_password; ?></td>
            <td>
                <input type="password" name="password" value=""/>
            </td>
        </tr>
        <tr>
            <td></td>
            <td><a href="<?php echo $forgotten; ?>" target="_blank"><?php echo $text_forgotten; ?></a></td>
        </tr>
    </table>

    <input type="submit" style="display: none;"/>
</form>